# CSTV App

CSTV is an iOS application designed to display matches and team details for e-sports using the [PandaScore](https://pandascore.co/) API. The app is built using the MVVM (Model-View-ViewModel) architecture and leverages RxSwift for reactive programming. It also includes unit tests to ensure the reliability and quality of the code.

## Features

- List of e-sports matches with detailed information.
- Detailed team information, including players, statistics, and more.
- Real-time updates for live matches.
- Intuitive and responsive navigation.

## Tech Stack

- **Language**: Swift
- **Architecture**: MVVM (Model-View-ViewModel)
- **Libraries**:
  - **RxSwift**: Used for reactive programming.
  - **RxCocoa**: Complements RxSwift with bindings for UIKit.

## MVVM Architecture

The app follows the MVVM (Model-View-ViewModel) architecture, which clearly separates responsibilities:

- **Model**: Represents the application's data. In this project, models like `MatchsModel` and `Team` represent entities retrieved from the PandaScore API.
  
- **View**: Responsible for the user interface. In our case, `ShowDetailsViewController` is one of the views displaying detailed information about a match.

- **ViewModel**: Handles business logic and provides data to the View. For example, `DetailsViewModel` and `MatchListViewModel` mediate between data requests and UI updates.

Using MVVM allows the separation of business logic and UI logic, making the app easier to maintain, test, and scale.

## Use of RxSwift

### What is RxSwift?

**RxSwift** is a library for asynchronous and event-based programming. It enables you to manipulate event sequences and transform, filter, combine, and manage data streams declaratively.

### How RxSwift is Used

In the CSTV App, RxSwift is used for:

- **Managing Asynchronous State**: Since the app relies on network data, which can be slow or unreliable, we use RxSwift to observe and react to state changes, such as data loading (`isLoading`) or new data reception (`dataRelay`).

- **Binding Between ViewModel and View**: RxSwift allows the ViewModel to notify the View of changes without complex callbacks. We use `BehaviorRelay` and `PublishRelay` to communicate changes between the ViewModel and the View.

- **Simplifying Network Requests**: Asynchronous requests to the PandaScore API are handled using `Single`, an observable type that emits a single value or error.

Example usage:

```swift
viewModel.fetchTeam(teamID: 1)
    .subscribe(onSuccess: { success in
        print("Fetch successful!")
    }, onFailure: { error in
        print("Error fetching team: \(error)")
    })
    .disposed(by: disposeBag)
```

## Integration with PandaScore API

The CSTV App uses the [PandaScore](https://pandascore.co/) API to retrieve information about e-sports matches and teams. The following API features are utilized:

- **List of Matches**: `fetchAllMatches` retrieves all available e-sports matches, combining ongoing and upcoming matches.
- **Team Details**: `fetchTeam` retrieves detailed information about a specific team, including a list of players.

All requests are made asynchronously using `RxSwift` to handle responses and errors.

## Unit Testing

### Test Structure

Unit tests are written using Xcode's standard testing framework, `XCTest`, alongside `RxSwift` to manage asynchronicity and validate reactive behaviors.

#### Example Unit Test

Tests are written to validate the behavior of the ViewModels. For example, for `DetailsViewModel`, we test:

- **Success in Fetching Team Data**: We verify that data is correctly added when a request is successful.
- **Failure in Fetching Team Data**: We check that errors are correctly propagated and handled.

```swift
func testFetchTeam_Success() {
    // Simulate a successful API response
    let team = Team(id: 1, name: "Team1", acronym: "T1", imageUrl: "https://example.com/team.png", players: [])
    mockService.fetchTeamResult = .just(team)

    let expectation = self.expectation(description: "Expected fetchTeam to succeed")
    
    viewModel.fetchTeam(teamID: 1)
        .subscribe(onSuccess: { success in
            XCTAssertTrue(success, "Expected fetchTeam to succeed")
            expectation.fulfill()
        }, onFailure: { error in
            XCTFail("Expected fetchTeam to succeed, but it failed with error: \(error)")
        })
        .disposed(by: disposeBag)

    waitForExpectations(timeout: 1.0, handler: nil)
}
```

### Test Coverage

The tests cover both success and failure scenarios to ensure the app behaves correctly under different API responses and error conditions.

## How to Run the Project

1. Clone this repository:
   ```bash
   git clone https://github.com/your-username/cstv-app.git
   cd cstv-app
   ```

2. Install dependencies:
   - If using **CocoaPods**:
     ```bash
     pod install
     ```
   - Open the project using the `.xcworkspace` file.

3. Configure your PandaScore API key:
   - Add your API key to the configuration file or as an environment variable.

4. Run the project:
   - Select the `CSTV` scheme and run (`Cmd + R`).

## How to Run Tests

1. Open the project in Xcode.
2. Select the `CSTVTests` scheme.
3. Press `Cmd + U` to run the tests.
