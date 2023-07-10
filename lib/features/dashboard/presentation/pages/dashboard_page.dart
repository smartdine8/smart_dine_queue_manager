import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:smartdine_queue_manager/core/extensions/sized_box_extension.dart';
import 'package:smartdine_queue_manager/core/navigation/navigation_services.dart';
import 'package:smartdine_queue_manager/core/theme/smartdine_colors.dart';
import 'package:smartdine_queue_manager/core/utils/smartdine_images.dart';
import 'package:smartdine_queue_manager/features/dashboard/dashboard_dependency_injection.dart';
import 'package:smartdine_queue_manager/features/dashboard/data/models/customer_model.dart';
import 'package:smartdine_queue_manager/features/dashboard/data/models/table_model.dart';
import 'package:smartdine_queue_manager/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:smartdine_queue_manager/features/dashboard/presentation/pages/today_special_page.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/core.dart';
import '../../../../core/widgets/circular_progress_widget.dart';
import '../widgets/custom_dropdown_widget.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  final TextEditingController customerNameController = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();

  final TextEditingController filterController = TextEditingController();

  final DashBoardCubit dashBoardCubit = slDashBoard<DashBoardCubit>();

  final _addCustomerFormKey = GlobalKey<FormState>();

  List<CustomerModel> customerList = [];

  List<CustomerModel> filteredCustomerList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: SmartDineColors.lightPrimaryColor,
            onPressed: () {
              _showAddCustomerDialog(context);
            },
            label: const Icon(Icons.add)),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: MediaQuery.of(context).size.width > 800
              ? Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: _buildHeader(),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTablesView(context),
                          _buildVerticalDivider(context),
                          _buildQueueView(context)
                        ],
                      ),
                    ),
                  ],
                )
              : const Center(child: Text('Expand to full screen.')),
        ),
      ),
    );
  }

  Widget _buildTablesView(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.55,
        child: Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10)),
                height: MediaQuery.of(context).size.height * 0.05,
                child: const Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tables',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 600,
                height: MediaQuery.of(context).size.height * 0.85,
                child: StreamBuilder<QuerySnapshot>(
                    stream: dashBoardCubit.getAllTables(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressWidget();
                      } else {
                        final List<TableModel> tableList = snapshot.data!.docs
                            .map((doc) => TableModel.fromJson(doc.data()))
                            .toList();

                        tableList.sort((a, b) => int.parse(a.totalCapacity!)
                            .compareTo(int.parse(b.totalCapacity!)));

                        dashBoardCubit.resetTableData(tableList);
                        return GridView.builder(
                          itemCount: tableList.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(20),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemBuilder: (context, index) {
                            CustomerModel? model;
                            return DragTarget<CustomerModel>(
                              onAcceptWithDetails: (dragDetails) async {
                                model = dragDetails.data;

                                // if table is empty
                                if (!tableList[index].isOccupied! &&
                                    model != null &&
                                    int.parse(
                                            tableList[index].totalCapacity!) >=
                                        int.parse(
                                            model!.customerPeopleCount!)) {
                                  dashBoardCubit.updateTableData(
                                      tableList[index], model);
                                  dashBoardCubit.deleteCustomer(model!);

                                  //calculate avg time to empty table using order + chef data
                                  tableList[index].time = await dashBoardCubit
                                      .getPredictionTimeToEmptyTable(
                                          model: tableList[index],
                                          personCount: int.parse(
                                              model!.customerPeopleCount!))
                                      .then((value) => tableList[index].time =
                                          value.toString());
                                }
                              },
                              builder: (BuildContext context,
                                  List<Object?> candidateData,
                                  List<dynamic> rejectedData) {
                                return Card(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: (!tableList[index].isOccupied!)
                                            ? Colors.black12
                                            : SmartDineColors.lightCreamColor),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, top: 8, left: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              tableList[index].isOrderPlaced!
                                                  ? Row(
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .watch_later_outlined,
                                                          size: 16,
                                                        ),
                                                        Text(
                                                            '${tableList[index].time} mins')
                                                      ],
                                                    )
                                                  : const SizedBox(),
                                              CircleAvatar(
                                                radius: 10,
                                                backgroundColor: SmartDineColors
                                                    .lightPrimaryColor,
                                                child: Text(
                                                  '${tableList[index].totalCapacity}',
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 80,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.asset(
                                              SmartDineImages.tableImage,
                                              fit: BoxFit.cover,
                                              height: 80,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '${tableList[index].tableName}',
                                          style: const TextStyle(
                                              color: SmartDineColors
                                                  .lightPrimaryColor),
                                        ),
                                        if (tableList[index].customerName !=
                                                null &&
                                            tableList[index]
                                                .customerName!
                                                .isNotEmpty)
                                          _buildCustomerDataRow(
                                              tableList[index])
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVerticalDivider(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.10,
      child: const Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: VerticalDivider(
          width: 1,
          thickness: 1,
          indent: 10,
          color: SmartDineColors.lightPrimaryColor,
        ),
      ),
    );
  }

  Widget _buildQueueView(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.35,
      child: StreamBuilder(
        stream: dashBoardCubit.getAllCustomers(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressWidget();
          } else {
            customerList = snapshot.data!.docs
                .map((e) => CustomerModel.fromJson(e))
                .toList();

            // sort list on first come first serve basis
            customerList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));

            // data!.docs
            //      .map((doc) => TableModel.fromJson(doc.data()))
            //      .toList()
            //  e
            // customerList.sort((a,b)=>a.customerPeopleCount!.compareTo(b.customerPeopleCount!));

            if (filterController.text.trim().isNotEmpty) {
              customerList = filteredCustomerList;
            }
            return StreamBuilder(
              stream: dashBoardCubit.getAllTables(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressWidget();
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 60),
                        child: _buildSearchQueueView(context, customerList),
                      ),
                      SingleChildScrollView(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.60,
                          width: 300,
                          child: customerList.isEmpty
                              ? const Text('No customers in queue.')
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: customerList.length,
                                  itemBuilder: (context, index) {
                                    return Draggable(
                                      feedback: SizedBox(
                                          width: 300,
                                          child: _buildDraggableCustomerTile(
                                              context, customerList[index])),
                                      data: customerList[index],
                                      onDragCompleted: () {},
                                      child: _buildDraggableCustomerTile(
                                          context, customerList[index]),
                                    );
                                  }),
                        ),
                      )
                    ],
                  );
                }
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildSearchQueueView(
      BuildContext context, List<CustomerModel> customerList) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.18,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.black12, borderRadius: BorderRadius.circular(10)),
            height: MediaQuery.of(context).size.height * 0.05,
            child: const Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Queue',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ],
            ),
          ),
          20.verticalSpace,
          SizedBox(
            width: 300,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: SearchBar(
                controller: filterController,
                hintText: 'Enter name',
                trailing: const [Icon(Icons.search)],
                onChanged: (query) {
                  _searchInCustomerList(query, customerList);
                },
              ),
            ),
          ),
          20.verticalSpace,
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Icon(
                Icons.food_bank,
                size: 32,
              ),
              Text(
                'SmartDine Queue Manager',
                style:
                    TextStyle(color: SmartDineColors.blackColor, fontSize: 20),
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  // lastly added feature
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TodaySplEditPage()));
                },
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.menu_book),
                ),
              ),
              const CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 24,
                child: Icon(
                  Icons.person,
                  color: SmartDineColors.blackColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDraggableCustomerTile(
      BuildContext context, CustomerModel customerModel) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: customerModel.customerPeopleCount != null
            ? CircleAvatar(
                backgroundColor: SmartDineColors.greyColor,
                child: Text(
                  '${customerModel.customerPeopleCount}',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: SmartDineColors.blackColor),
                ),
              )
            : null,
        title: Text(customerModel.customerName ?? 'customer'),
        subtitle: customerModel.customerMobile != null
            ? Text(
                '+91 ${customerModel.customerMobile}',
                style: const TextStyle(color: SmartDineColors.lightBlackColor),
              )
            : null,
        trailing: SizedBox(
          width: 60,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: () {
                    _showDeleteCustomerDialog(context, customerModel);
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Colors.black38,
                  )),
              4.horizontalSpace,
              Visibility(
                visible: !kIsWeb,
                child: GestureDetector(
                  onTap: () async {
                    if (!kIsWeb && Platform.isAndroid || Platform.isIOS) {
                      await FlutterPhoneDirectCaller.callNumber(
                          '+911234567890');
                    }
                  },
                  child: const Icon(
                    Icons.phone,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showAddCustomerDialog(BuildContext context) {
    int selectedCount = 1;
    AlertDialog alert = AlertDialog(
      title: const Text('Create Customer Entry'),
      content: Form(
        key: _addCustomerFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter customer name';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Enter Name",
                labelText: "Enter Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              controller: customerNameController,
            ),
            10.verticalSpace,
            Row(
              children: [
                const Text('+91'),
                8.horizontalSpace,
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty || value.trim().length < 10) {
                        return 'Please mobile number';
                      }
                      return null;
                    },
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 10,
                    decoration: InputDecoration(
                      hintText: "Enter Phone Number",
                      labelText: "Enter Phone Number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    controller: phoneNumberController,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Number of people :',
                  style: TextStyle(color: SmartDineColors.lightBlackColor),
                ),
                10.horizontalSpace,
                CustomDropDownWidget(
                  getSelectedCount: (int count) {
                    selectedCount = count;
                  },
                )
              ],
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            NavigationService().pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // validate form
            if (_addCustomerFormKey.currentState!.validate()) {
              dashBoardCubit.createNewCustomer(CustomerModel(
                  customerId: const Uuid().v1(),
                  createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                  customerName: customerNameController.text.trim(),
                  customerPeopleCount: selectedCount.toString(),
                  customerMobile: phoneNumberController.text.trim(),
                  isVisiting: true,
                  customerRegisteredAt: DateTime.now().toUtc().toString()));
              //reset form
              customerNameController.clear();
              phoneNumberController.clear();
              selectedCount = 1;
              NavigationService().pop(context);
            }
          },
          child: const Text(''
              'Add'),
        ),
      ],
    );

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => alert);
  }

  _showDeleteCustomerDialog(BuildContext context, CustomerModel customerModel) {
    AlertDialog alert = AlertDialog(
      title: const Text('Delete Customer Entry'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              'Are you sure you want to delete entry for ${customerModel.customerName ?? 'this customer'} ?')
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            NavigationService().pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            dashBoardCubit.deleteCustomer(customerModel);
            NavigationService().pop(context);
          },
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => alert);
  }

  void _searchInCustomerList(String query, List<CustomerModel> customerList) {
    filteredCustomerList = customerList
        .where((element) =>
            element.customerName!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {});
  }

  Row _buildCustomerDataRow(TableModel tableModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.account_circle,
                    color: SmartDineColors.lightPrimaryColor,
                    size: 12,
                  ),
                  4.horizontalSpace,
                  Text(
                    '${tableModel.customerName}',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.groups,
                    color: SmartDineColors.lightPrimaryColor,
                    size: 12,
                  ),
                  4.horizontalSpace,
                  Text(
                    '${tableModel.customerPeopleCount}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
