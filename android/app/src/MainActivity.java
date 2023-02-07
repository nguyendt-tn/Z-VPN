import id.laskarmedia.openvpn_flutter.OpenVPNFlutterPlugin;

public class MainActivity extends FlutterActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        OpenVPNFlutterPlugin.connectWhileGranted(requestCode == 24 && resultCode == RESULT_OK);
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
    }
  }