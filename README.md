# E-Commerce App -- Shop

Shop
A Flutter e‑commerce demo with product browsing, search-style discovery, cart, checkout via Stripe Payment Sheet, and profile UI. Products load from FakeStore API; state is handled with Riverpod; structure follows layer-based Clean Architecture (data / domain / presentation). Theming and copy use centralized constants (AppColors, AppStrings).

## Terminology (Quick Glossary)

- **Flutter** Google’s UI toolkit, this app is built with Dart and Material widgets  
- **Material 3** Current Material Design system, theming and components follow M3 patterns  
- **Clean Architecture** Splitting code into layers so UI, business rules, and I/O stay separated and easier to test and change  
- **Layer-first layout** Folders grouped by role such as data, domain, presentation instead of feature based folders  

### Layers

- **Presentation layer** UI screens, widgets, and Riverpod providers that talk to the domain  
- **Domain layer** Pure business concepts like entities, repository interfaces, and use cases without Flutter or Dio imports  
- **Data layer** API and persistence including models, datasources, and repository implementations  

### Core Concepts

- **Entity** Simple immutable object representing a concept such as ProductEntity or CartItemEntity  
- **Model** Data class mapped from JSON and can convert to `toEntity()` for the domain layer  

### Architecture

- **Repository (abstract)** Contract in domain defining what the app needs like get products or create payment intent  
- **Repository implementation** Concrete class in data that fulfills the contract using datasources  
- **Use case** Single purpose class or function that performs one business action like GetProductsUseCase or CreatePaymentIntentUseCase  
- **Datasource** Low level access to remote APIs such as Dio calls to FakeStore or Stripe REST  

### Tools & Libraries

- **Dio** HTTP client used for REST calls such as products and payment intent creation  
- **Riverpod** State management and dependency access using providers  

### Riverpod Concepts

- **Provider** Unit that exposes a value or service such as configured Dio or a use case  
- **ref.watch** Subscribes to a provider and rebuilds widget when value changes  
- **ref.read** One time read without subscribing  
- **ref.listen** Reacts to provider changes for side effects like showing snackbar after payment  
- **StateNotifier / StateNotifierProvider** Holds mutable state with explicit methods such as CartNotifier or PaymentNotifier  
- **FutureProvider** Async provider used for loading data with loading, error, and data states  
- **StateProvider** Simple mutable value like bottom navigation index  

### App Structure

- **Dependency Injection (DI)** Wiring implementations using Riverpod providers inside core/di/providers.dart  
- **ProviderScope** Root widget that enables Riverpod across the app  
- **ConsumerWidget / ConsumerStatefulWidget** Widgets that receive `WidgetRef ref` to use providers  

### UI & Navigation

- **IndexedStack + NavigationBar** Bottom tabs that keep each tab alive while switching  
- **Scaffold / Drawer** Material layout structure with side menu  
- **SafeArea** Avoids system UI overlaps like notches  
- **Navigator / MaterialPageRoute** Handles screen navigation like pushing CartScreen  

### Payments

- **Stripe** Payment platform using `flutter_stripe` for native UI  
- **Payment Sheet** Prebuilt checkout UI provided by Stripe  
- **PaymentIntent** Server side object representing a payment, requires `client_secret` on client  

### Android Specific

- **FlutterFragmentActivity** Required Android activity for Stripe support  
- **Theme.MaterialComponents** Required Android theme for Stripe compatibility  

### Dev Tools

- **flutter_launcher_icons** Generates app launcher icons from a single image  
- **flutter_native_splash** Generates native splash screens and may override Android themes on newer APIs  

### Utilities

- **AppColors / AppStrings** Central place for colors and strings  
- **FakeStore API** Public demo REST API used for product data  

https://github.com/user-attachments/assets/0116f1d9-bc09-4fce-978a-936b13214564

