# TheMovieApp

1. HOW TO BUILD THE APP:
  - Clone the project
  - Navigate to the project folder through the terminal
  - execude pod install command
  - if pods are not installed on your machine, follow the installation guide at https://guides.cocoapods.org/using/getting-started.html

2. APP ARCHITECTURE:
   - Project uses very clean and simple architecture with MVVM design pattern which is ideal for the projects of this type
   - Project consists 6 essential folders:
      - Infrastructure (Contains networking clients and global infrastructure configurations)
      - Utils & Extensions (Contains custom reusable UI components and extensions on Foundation and UIKit views)
      - Repositories (Contains repositories which prepare and execute network requests for specific feature, usually named the same as the feature)
      - Models (Data models, mostly used as an API decodable objects)
      - Features (Screens that are shown in the app, each feature usually contains UIViewController+Xib file and a viewModel)
      - Resources (Contains project info.plist, image assets and all types of resources)
   - Data binding between viewmodel and viewcontroller is achieved by using RxSwift

3. Libraries used:
   - RxSwift (Reactive framework used for a network calls and data bindings )
   - RxCocoa (Provides many useful reactive capabilities, mostly used as an extension on UIKit components)
   - KingFisher (Library used for async image downloading and caching, very useful when dealing with many calls, for example in collection views)

I tried to use as few libraries as possible, since more libraries = more problems.
If I had more time, I would implement async loading for the details fields on movie and tvshow details fields and I would cover the app with the tests.
