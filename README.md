# nashididv_flutter

A new Flutter project.


**Introduction:**

The NashidSDK is a library designed to streamline document data extraction and authenticity verification within Flutter applications. This comprehensive SDK encompasses four primary steps: Optical Character Recognition (OCR), Near Field Communication (NFC) reader, liveness detection, and document photo comparison. By integrating the NashidSDK into your application, you can enhance security measures and improve the efficiency of identity verification processes.

**Integration Steps:**

1. **Prerequisites:**

- Ensure that your iOS application targets iOS 13.0 or higher and xcode 13 or higher

1. **Installation:**
- To integrate the NashidSDK into your project, simply add the following CocoaPod to your Podfile:

```pod 'Nashid_SDK', '1.9.0'```

1. **Add script inside the pod file (End of the file):**
```
post\_install do |installer|

    installer.generated\_projects.each do |project|

          project.targets.each do |target|

              target.build\_configurations.each do |config|

                  config.build\_settings['IPHONEOS\_DEPLOYMENT\_TARGET'] = '13.0'

               end

          end

   end


    installer.pods\_project.targets.each do |target|

      target.build\_configurations.each do |config|

        config.build\_settings['DEBUG\_INFORMATION\_FORMAT'] = 'dwarf-with-dsym'

        config.build\_settings['OTHER\_SWIFT\_FLAGS'] = '-no-verify-emitted-module-interface'

        config.build\_settings['BUILD\_LIBRARY\_FOR\_DISTRIBUTION'] = 'YES'

      end

    end

end
```
**Note:** The app's Info.plist must contain an NSCameraUsageDescription key with a string value explaining to the user how the app uses this data.

1. **Change build Setting:**
- Go to **Build Settings** and search **User Script Sandboxing** and **SET value No**

1. **Open AppDelegate file:**
- Import the framework import IDVSDK
- Add following code in `didFinishLaunchingWithOptions` methods 

```
  // 1
  let controller : FlutterViewController = window?.rootViewController as! FlutterViewController


  // 2
  let deviceChannel = FlutterMethodChannel(name: "test.flutter.methodchannel/iOS", binaryMessenger: controller.binaryMessenger)

        
  // 3
  prepareMethodHandler(deviceChannel: deviceChannel) GeneratedPluginRegistrant.register(with: self)

  // 4
  NashidSDK.shared.initializeSDK(token: "YOUR\_SDK\_TOKEN", id: "YOUR\_SDK\_ID", baseUrl: END\_POINT\_URL, employeeEmail: EMAIL, languageId: LANGUAGE\_ID)

  // 5
  NashidSDK.shared.scanResultCallback = { nashidResult, type in
              print(nashidResult)
  }
```

  **Note:** Step 5 you will receive the result, You need pass this result you flutter project whenever you required   

  To initialize the NashidSDK and access its functionalities, use the following code snippet

NashidSDK.shared.initializeSDK(token: "YOUR\_SDK\_TOKEN", id: "YOUR\_SDK\_ID", baseUrl: END\_POINT\_URL, employeeEmail: EMAIL, languageId: LANGUAGE\_ID)

- Replace "YOUR\_SDK\_TOKEN" with the Bearer token key obtained from the dashboard (Check screenshot\_1).
- Replace "YOUR\_SDK\_ID" with the CompanyUUID key obtained from the dashboard. (Check screenshot\_1).
- Replace "END\_POINT\_URL" with the API base url
- Replace "EMAIL" with the employee email which you registered on the dashboard.
- Replace "LANGUAGE\_ID" with the en 0r ar, based on the we will set app language

![](Aspose.Words.cf99b3d4-871f-4e52-a113-56530070c804.001.png)



1. **Add Handler Method in AppDelegate file:**
- Add `prepareMethodHandler` Method at the last of app Delegate file

```
  private func prepareMethodHandler(deviceChannel: FlutterMethodChannel) {
          // 1
          deviceChannel.setMethodCallHandler({
             (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
              // 2
              if call.method == "scanDocument" {
                  // 3
                  NashidSDK.shared.documentScan()
              } else if call.method == "scanPassport" {
                  // 4
                  NashidSDK.shared.passportScan()
              }
          })
      }
```
**SDK Features**:

1. **OCR (Optical Character Recognition):**

- Extracts text information from document images using advanced OCR techniques.
- Recognizes and extracts crucial data such as names, dates of birth, expiry dates, and identification numbers from documents.

1. **NFC (Near Field Communication) Reader:**

- Enables seamless reading of data from NFC-enabled documents such as e-passports or identity cards.
- Facilitates quick and secure retrieval of document information using NFC technology.
1. **Liveness Detection:**

- Verifies the liveness of individuals by analyzing facial features and performing biometric checks.
- Ensures that individuals interacting with the application are physically present, preventing spoofing or fraudulent attempts.

1. **Document Photo Comparison:**

- Compares the liveness photo captured during the verification process with the photo extracted from the document.
- Enhances security measures by determining if the individual's face matches the photo in the document, thereby preventing identity fraud.

Upon completion, the library provides a comprehensive result containing all extracted document data, including text information, NFC data, liveness verification status, and the outcome of the document photo comparison. This consolidated result is suitable for identity verification or document processing workflows.

**Usage Examples:**

Create platform channel:  

const platformChannel = MethodChannel('test.flutter.methodchannel/iOS');


- If you want scan the Id card then invoke this channel

```
  try {
     	 // 1
      	final String result = await platformChannel.invokeMethod('scanDocument');
   	} catch (e) {
}
```

- If you want scan the passport then invoke this channel

```
  try {
     	 // 1
      final String result = await platformChannel.invokeMethod(scanPassport);
   	} catch (e) {
  }
```

**Getter Methods:**

1. scanResultCallback: (([String: Any], String) -> Void)?
   - Retrieve the result callback.
   - Here is a sample response 
```
[

    {

        `"scan\_type": "Card",

        `"scan\_data": {

            `"NFC": {

                `"Identity Number": "0113414632",

                `"Issue Date": "2018-20-12",

                `"Expiry Date": "2020-20-11",

                `"Place of Issue (Arabic)": "مسقط",

                `"Place of Issue (English)": "Seeb Resident",

                `"Full Name (Arabic)": "رئيس حيدر",

                `"Full Name (English)": "RAIS HAIDER",

                `"Date of Birth": "1989-12-01",

                `"Country of Birth (Arabic)": "الهند",

                `"Country of Birth (English)": "INDIA",

                `"Nationality (Arabic)": "هندي",

                `"Gender (Arabic)": "ذكر",

                `"Nationality (English)": "INDIAN",

                `"Gender (English)": "Male",

                `"Visa Number": "60102081",

                `"Permit Type": "EMPLOYMENT SINGLE",

                `"Use By Date": "2020-25-12",

                `"Permit Number": "11751182",

                `"Company Name (Arabic)": "مشاريع المازن للشرق الاوسط",

                `"Company Name (English)": "ALMAZEM PROJECTS FOR THE MODLE EAST",

                `"Company Address (Arabic)": "\nالموالح, السيب\nالصندوق البريدي 366, الرمز البريدي 114"

            `},

            `"scan": {

                `"Date of Birth (DD MMM YYYY)": "31 Mar 1992",

                `"Document No": "130810343",

                `"Expiry Date (DD MMM YYYY)": "04 Apr 2029",

                `"Expiry Date Formatted": "2025-04-05",

                `"Full Name": "MUHAMMAD SAJID SHERIFF ",

                `"country": "OMN",

                `"Document Type": "ID",

                `"Nationality": "LKA",

                `"Gender": "MALE",

                `"MRZ text": "130810383392033102504042",

                `"Date of birth": "920332",

                `"Date of Birth Formatted": "1992-03-30"

            `},

            `"scanImage": {

                `"after-crop-back": UIImage Object,

                `"liveness-image": UIImage Object,

                `"after-crop-front": UIImage Object,

                `"before-crop-back": UIImage Object,

                `"face-Before-Remove-Background-Liveness": UIImage Object,

                `"before-crop-front": UIImage Object

            `},

            `"Liveness": {

                `"AML Screening": false,

                `"Liveness Confirmed": true,

                `"Match value": "0.68749946"

            `}

        `},

        `"scan\_code": "bxnnxms",

        `"scan\_status": 1,

        `"uuid": "BRJJVNDIS7GXSDD"

    `}

]

Type: Card/Passport
```
1. documentScan()
   - Open the ID card scan module.
1. passportScan()
   - Open the Passport scan module.
1. isIntroductionEnabled()
   - Check whether instructions are enabled during the verification process.
   - Parameters:
     - `context`: The context of the iOS application.


