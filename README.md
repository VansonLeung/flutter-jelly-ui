# flutter_jellyui

A UI family that interacts and animates like a jelly!

## Prerequisites
- dart sdk: '>=2.17.0 <4.0.0'
- flutter: ">=1.17.0"

## Installation

Add to pubspec.yaml:
```yaml
flutter_jellyui: ^1.0.0
```

## Usage

#### `JellyUiButton`

https://github.com/VansonLeung/flutter-jelly-ui/assets/1129695/8af8c353-d5fa-4f73-803a-816bfa75166a

```dart
// JellyUiButton: Direct drop-in replacement of ElevatedButton
JellyUiButton(
  onPressed: () {
    
  },
  child: Text(
    'Cancel',
  ),
)
```


#### `JellyUiContainer`

https://github.com/VansonLeung/flutter-jelly-ui/assets/1129695/6d66d264-502d-4738-b9fc-3b77ea911ce9

```dart
// JellyUiContainer - Jelly-style dialogs support
void _displayJellyDialog() {
  showDialog(context: context, builder: (BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return JellyUiContainer(

      onWillPop: () {
        return Future(() => false);
      },

      child: Container(
        margin: EdgeInsets.fromLTRB(max(30, screenWidth * 0.1), max(30, screenHeight * 0.1), max(30, screenWidth * 0.1), max(30, screenHeight * 0.1)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 2),
              blurRadius: 6,
              spreadRadius: 2.0,
            )
          ],
        ),

        child: Padding(
            padding: const EdgeInsets.fromLTRB(32, 32, 32, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Title here",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                SizedBox(height: 12,),

                Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                SizedBox(height: 24,),


                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    JellyUiButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                      ),
                    ),


                    SizedBox(width: 24,),


                    JellyUiButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          _displayJellyDialog();
                        });
                      },
                      child: Text(
                        'OK',
                      ),
                    ),
                  ],
                )

              ],
            )
        ),

      ),
    );
  });

}

```



### Milestones
```
☐ Better support for other user-interactable Material elements / drop-in Material classes e.g. Checkbox, Radio, SegmentedButton  
☐ Better support for other generic elements e.g. Text, Snackbar
☐ Add limited rebound_dart capability as an alternative of AnimationBuilder
☐ Add extensive ways to animate the jelly passively (via state change) or actively (via controller method call)
☐ Create documentations for the said extensive ways above
☐ Performance improvement
☐ Local animation toggle settings
☐ Global animation toggle settings
