import 'dart:html';
import 'dart:typed_data';

typedef UploadHtmlHelperCallback = void Function(Uint8List file, String name);

final class UploadHtmlHelper {
  void startUpload(UploadHtmlHelperCallback callback) {
    final uploadInput = FileUploadInputElement()..click();
    uploadInput.onChange
        .listen((event) => handleFileUpload(uploadInput, callback));
  }

  void handleFileUpload(
    FileUploadInputElement uploadInput,
    UploadHtmlHelperCallback callback,
  ) {
    final files = uploadInput.files;
    if (files != null && files.isNotEmpty) {
      final file = files.first;
      final reader = FileReader()..readAsArrayBuffer(file);

      reader.onLoadEnd.listen((_) {
        final bytes =
            Uint8List.fromList((reader.result ?? const <int>[]) as List<int>);

        callback(bytes, file.name);
      });
    }
  }
}
