# ValidationManager

A lightweight Swift package for validating Iranian-specific inputs:

- Phone numbers (with or without leading zero)  
- National codes (کد ملی)  
- Bank card numbers (prefix checks + Luhn)  
- Card security (PIN & CVV2)  
- Limited-range numeric checks

This README is ready to copy-paste into your `README.md`.

---

## Features

- Strategy-based validators conforming to a single `Validator` protocol  
- Clear `ValidationState` with `.notEvaluated`, `.valid`, `.invalid(error:)`, `.invalidLength(error:)` and a `color` for UI feedback  
- Customizable messages via `Config<T>`  
- Uses a `Banks.json` resource for card prefix matching  
- Easy to extend with your own validators

---

📦 Installation

Swift Package Manager (SPM)

You can add ValidationManager via Xcode:

https://github.com/pooyan88/ValidationManager

Or add the following in your Package.swift:

.package(url: "https://github.com/pooyan88/ValidationManager", from: "1.0.0")

🚀 Usage
Import your package module name (example uses ValidationManager). Replace with your actual module name if different.
Phone number

```swift

import IranianInputValidator
import UIKit

let phoneConfig = Config(
    input: "09123456789",
    invalidMessage: "Phone number format is invalid.",
    invalidLengthMessage: "Phone number length is incorrect."
)

let phoneValidator = PhoneNumberValidation(config: phoneConfig)
let phoneState = phoneValidator.validate()

switch phoneState {
case .valid:
    print("Phone is valid")
case .invalid(let error), .invalidLength(let error):
    print("Phone invalid: \(error)")
case .notEvaluated:
    break
}

```
```swift
National code (کد ملی)

let cardConfig = Config(
    input: "6037991234567890",
    invalidMessage: "Card number is invalid.",
    invalidLengthMessage: "Card number must be 16 digits."
)

let cardValidator = CardNumberValidator(config: cardConfig)
let cardState = cardValidator.validate()

// Inspect results:
switch cardState {
case .valid:
    print("Card valid")
case .invalid(let err):
    print("Card invalid: \(err)")
case .invalidLength(let err):
    print("Card length error: \(err)")
default:
    break
}
```

```swift
Card number
let cardConfig = Config(
    input: "6037991234567890",
    invalidMessage: "Card number is invalid.",
    invalidLengthMessage: "Card number must be 16 digits."
)

let cardValidator = CardNumberValidator(config: cardConfig)
let cardState = cardValidator.validate()

// Inspect results:
switch cardState {
case .valid:
    print("Card valid")
case .invalid(let err):
    print("Card invalid: \(err)")
case .invalidLength(let err):
    print("Card length error: \(err)")
default:
    break
}
```


Note: Card validator reads bank prefixes from Banks.json via Loader (uses Bundle.module.url(forResource:withExtension:)). Ensure Banks.json is added to your package resources.
CVV2 / PIN (CardSecurityValidator)

```swift
// CVV2 example
let cvvConfig = Config(
    input: CardSecurityValidator.SecurityType.cvv2(text: "123", min: 3, max: 4),
    invalidMessage: "CVV2 must contain only digits.",
    invalidLengthMessage: "CVV2 length is invalid."
)

let cvvValidator = CardSecurityValidator(config: cvvConfig)
let cvvState = cvvValidator.validate()

// PIN example
let pinConfig = Config(
    input: CardSecurityValidator.SecurityType.pin(text: "1234", min: 4, max: 6),
    invalidMessage: "PIN must be numeric.",
    invalidLengthMessage: "PIN length is invalid."
)

let pinValidator = CardSecurityValidator(config: pinConfig)
let pinState = pinValidator.validate()

```

```swift

Limited number (min / max)

let limit = LimitedNumberValidator.Limit(number: "25", min: 20, max: 30)
let limitedConfig = Config(
    input: limit,
    invalidMessage: "Number is invalid.",
    invalidLengthMessage: "Number is outside the allowed range."
)

let limitedValidator = LimitedNumberValidator(config: limitedConfig)
let limitedState = limitedValidator.validate()
```

Important: The LimitedNumberValidator uses Limit(number:min:max) struct — supply the number as a String and the min/max as Int.
ValidationManager (strategy)

let manager = ValidationManager(strategy: phoneValidator)
let managerResult = manager.validate()
print(managerResult)

Banks.json
The CardNumberValidator depends on a JSON file (example name: Banks.json) containing an array of bank models and their prefixes. Put this JSON in your package resources (and reference it as "Banks" when using Loader.Load).
Example minimal Banks.json structure:

```json
[
  {
    "name": "Example Bank",
    "prefixes": ["603799", "639347"]
  }
]
```

Extending
Create your own validator by conforming to Validator:

public struct MyCustomValidator: Validator {
    public func validate() -> ValidationState {
        // return .valid / .invalid(error:) / .invalidLength(error:)
    }
}
Then you can plug it into ValidationManager.
Tests
Add unit tests in your test target that instantiate validators with various inputs and assert expected ValidationState values.

License
MIT License — see LICENSE for details.
