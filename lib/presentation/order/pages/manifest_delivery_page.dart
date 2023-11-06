import 'package:ecommerce/core.dart';
import 'package:ecommerce/data/models/responses/buyer_order_response_model.dart';

class ManifestDeliveryPage extends StatefulWidget {
  const ManifestDeliveryPage({
    Key? key,
    required this.buyerOrder,
  }) : super(key: key);
  final BuyerOrder buyerOrder;

  @override
  State<ManifestDeliveryPage> createState() => _ManifestDeliveryPageState();
}

class _ManifestDeliveryPageState extends State<ManifestDeliveryPage> {
  List<StepperData> stepperData = [];

  @override
  void initState() {
    context.read<CekResiBloc>().add(CekResiEvent.getCekResi(
          resi: widget.buyerOrder.attributes.noResi,
          courier: widget.buyerOrder.attributes.courierName,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lacak Pengiriman'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: BlocBuilder<CekResiBloc, CekResiState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return const Center(
                      child: Text('Resi not found'),
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  loaded: (data) {
                    int indexStep = 0;
                    stepperData = data.rajaongkir.result.manifest.map((e) {
                      indexStep++;
                      return StepperData(
                        title: StepperText(
                          e.manifestCode,
                          textStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        subtitle: StepperText(
                            '${e.manifestDate.toFormattedDateWithDay()} ${e.manifestTime} \n ${e.manifestDescription}'),
                        iconWidget: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: Center(
                            child: Text(
                              '$indexStep',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList();
                    return AnotherStepper(
                      stepperList: stepperData,
                      stepperDirection: Axis.vertical,
                      iconWidth: 40,
                      // Height that will be applied to all the stepper icons
                      iconHeight:
                          40, // Width that will be applied to all the stepper icons
                    );
                  },
                  error: (error) => const Center(
                    child: Text('Resi not found'),
                  ),
                );
              },
            ),
          ),
        ));
  }
}

// StepperData(
//         title: StepperText(
//           "Order Placed",
//           textStyle: const TextStyle(
//             color: Colors.grey,
//           ),
//         ),
//         subtitle: StepperText("Your order has been placed"),
//         iconWidget: Container(
//           padding: const EdgeInsets.all(8),
//           decoration: const BoxDecoration(
//               color: Colors.green,
//               borderRadius: BorderRadius.all(Radius.circular(30))),
//           child: const Center(
//             child: Text(
//               "1",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14,
//               ),
//             ),
//           ),
//         )),
//     StepperData(
//         title: StepperText("Preparing"),
//         subtitle: StepperText("Your order is being prepared"),
//         iconWidget: Container(
//           padding: const EdgeInsets.all(8),
//           decoration: const BoxDecoration(
//               color: Colors.green,
//               borderRadius: BorderRadius.all(Radius.circular(30))),
//           child: const Center(
//             child: Text(
//               "2",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14,
//               ),
//             ),
//           ),
//         )),

//     StepperData(
//       title: StepperText("Delivered",
//           textStyle: const TextStyle(
//             color: Colors.grey,
//           )),
//     ),
