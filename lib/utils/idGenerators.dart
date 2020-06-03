import 'dart:convert';
import 'dart:math';

class IdGenerators {
    static final Random _random = Random.secure();

    static String createCryptoRandomString() 
    {
        int length = 19;
        String character = '-';

        var values = List<int>.generate(length, (i) => _random.nextInt(256));
        String id = character + base64Url.encode(values).substring(0,18);

        return id;
    }
}