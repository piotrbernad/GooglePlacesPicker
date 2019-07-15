# Google Places Picker
Highly customizable Place Picker which is based on Google Places API and Google Geocode services.

![](https://github.com/piotrbernad/GooglePlacesPicker/blob/master/images/picker.png?raw=true)
![](https://github.com/piotrbernad/GooglePlacesPicker/blob/master/images/picker2.png?raw=true)

Picker allows user to select the location directly on the map or use search with autocompletion. As a result it provides `GMSPlace` object.

# Installation via Carthage

![](https://img.shields.io/badge/Carthage-✔-f2a77e.svg?style=flat)

Add following line to your Cartfile:
```github "piotrbernad/GooglePlacesPicker"```

Import module using:
```import PlacePicker```

# Installation via Cocoapods

![](https://cocoapod-badges.herokuapp.com/v/PlacesPicker/badge.png)

Add following line to your Cartfile:
```pod 'PlacesPicker'```

Import module using:
```import PlacesPicker```

# Usage

To use Picker you need to provide Google Places API Key and Google Maps key to do so, you should call:

```
PlacePicker.configure(googleMapsAPIKey: "YOUR_KEY", placesAPIKey: "YOUR_PLACES_KEY")
```

Whenever you want to show controller call:

```
let controller = PlacePicker.placePickerController()
controller.delegate = self
let navigationController = UINavigationController(rootViewController: controller)
self.show(navigationController, sender: nil)
```

All events are delivered using `PlacesPickerDelegate`.

Optionally you can pass `PlacePickerConfig` which allows you to customize the look and behaviour of the picker.

# Customization

You can easily customize the look of map and the list itself. All you need to do is to implement your own class of Renderer protocols.

To customize the look of the list implement and pass renderer object during config initalization:

```
public protocol PlacesListRenderer {
    func registerCells(tableView: UITableView)
    func cellForRowAt(indexPath: IndexPath, tableView: UITableView, object: PlacesListObjectType) -> UITableViewCell
}
```

To customize the look of the MapView implement:

```
public protocol PickerRenderer {
    func configureCancelButton(barButtonItem: UIBarButtonItem)
    func configureSearchButton(barButtonItem: UIBarButtonItem)
    func configureMapView(mapView: GMSMapView)
    func configureTableView(mapView: UITableView)
}

```

# Contribution

Feel free to contribute.

## TODO

1. Setup cocoapods
2. Write tests
