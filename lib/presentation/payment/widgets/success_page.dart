import 'package:ecommerce/core.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Pembayaran Sukses',
        desc: 'Selamat Pembayaran Berhasil dilakukan',
        btnOkOnPress: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const DashboardPage();
          }));
        },
      ).show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
