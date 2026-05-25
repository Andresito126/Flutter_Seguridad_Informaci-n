import 'package:no_screenshot/no_screenshot.dart';
import 'package:seguridad_flutter/shared/services/ScreenshootProtection_service.dart';

class ScreenshootprotectionserviceImpl extends ScreenshootprotectionService {
  final NoScreenshot _noScreenshot = NoScreenshot.instance;

  @override
  Future<void> enableProtection() async{
    await _noScreenshot.screenshotOff();
  }

  @override
  Future<void> disableProtection() async{
    await _noScreenshot.screenshotOn();
  }
}