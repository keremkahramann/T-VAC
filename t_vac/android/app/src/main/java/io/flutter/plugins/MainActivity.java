package com.example.my_flutter_app;

import android.bluetooth.BluetoothAdapter;
import android.content.Intent;
import android.os.Bundle;

import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {
    private static final int REQUEST_ENABLE_BT = 1;
    private BluetoothAdapter bluetoothAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        if (bluetoothAdapter == null) {
            // Cihazda Bluetooth desteklenmiyor
            // İşlem yapılabilir hata yönetimi buraya yazılabilir
        } else {
            if (!bluetoothAdapter.isEnabled()) {
                // Bluetooth kapalıysa, açma isteği gönder
                Intent enableBtIntent = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
                startActivityForResult(enableBtIntent, REQUEST_ENABLE_BT);
            }
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode == REQUEST_ENABLE_BT) {
            if (resultCode == RESULT_OK) {
                // Bluetooth başarıyla açıldı
                // İşlem yapmak için BluetoothAdapter nesnesini kullanabilirsiniz
            } else {
                // Bluetooth açılmadı, gerekli işlem yapılamaz
                // İşlem yapılabilir hata yönetimi buraya yazılabilir
            }
        }
    }
}
