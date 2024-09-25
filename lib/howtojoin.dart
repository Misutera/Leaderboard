import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class HowToJoinPage extends StatelessWidget {
  const HowToJoinPage({super.key});

  final String _markdownText = '''
# Entry guide is in WIP

Have some Markdown Syntax guide instead :P

# This is a Heading h1
## This is a Heading h2
###### This is a Heading h6

## Emphasis

*This text will be italic*  
_This will also be italic_

**This text will be bold**  
__This will also be bold__

_You **can** combine them_

~~Oh, and this is strikethrough~~

## Lists

### Unordered

* Item 1
* Item 2
* Item 2a
* Item 2b

### Ordered

1. Item 1
2. Item 2
3. Item 3
    1. Item 3a
    2. Item 3b

## Images

![This is an alt text.](https://i.imgur.com/uZeQ3Xr.jpeg "This is a sample image.")

## Links

You may be using [Markdown Live Preview](https://markdownlivepreview.com/).

## Blockquotes

> Markdown is a lightweight markup language with plain-text-formatting syntax, created in 2004 by John Gruber with Aaron Swartz.
>
>> Markdown is often used to format readme files, for writing messages in online discussion forums, and to create rich text using a plain text editor.

## Tables

| Left columns  | Right columns |
| ------------- |:-------------:|
| left foo      | right foo     |
| left bar      | right bar     |
| left baz      | right baz     |

## Blocks of code

```
print('Hello, World!);
```

## Inline code

You can display inline code with backticks like `print('Hi!');`.

[^1]: This is the footnote.

''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SizedBox(
        width: 1000,
        child: Column(
          children: [
            topWidget(context),
            markdown(context),
          ],
        ),
      ),
    ));
  }

  Widget topWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          height: 50,
          child: Row(children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded)),
            const Expanded(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'How to Enter',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )),
          ])),
    );
  }

  Widget markdown(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          SelectionArea(
            child: Markdown(
              shrinkWrap: true,
              data: _markdownText,
              physics: const BouncingScrollPhysics(),
              styleSheet: MarkdownStyleSheet(
                h1: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
                h2: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary),
                // code: TextStyle(
                //     backgroundColor: Colors.grey.shade900,
                //     color: Colors.white,
                //     fontSize: 14),
                codeblockDecoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                blockquoteDecoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(5),
                ),
                codeblockPadding: const EdgeInsets.all(5.0),
                textAlign: WrapAlignment.spaceBetween,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
