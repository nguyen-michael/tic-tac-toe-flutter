# tic_tac_toe

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Brainstorm a tic-tac-toe app

The oft done tic-tac-toe app is good practice for learning new frameworks. It involves tracking win/loss/tie conditions and display as well as user input.

Perhaps the board can be displayed as a simple array of numbers in the set { 0, 1, 2 }, where 0 represents an empty unplayed spot and 1 and 2 represents spots played by the players 1 and 2 respectively.

The indexes can be drawn as such: 
```
0 1 2
3 4 5
6 7 8
```

We can then hard code win conditions (there's only 16, 8 per player). Say

```
0 1 0
2 1 2
0 1 2
```

as [0, 1, 0, 2, 1, 2, 0, 1, 2]. This runs into the problem of needing to encode all variations of this win condition (i.e. the different positions of 2's).

We can get around this in more than one way. We can use an "answer" key to list all the eight possible win conditions for either player, for example:

```
2 ? ?
? 2 ?
? ? 2
```
as [1, 0, 0, 0, 1, 0, 0, 0, 1]. We can then compare the board to all these conditions after each turn. First to match a win condition, wins!

The tie condition is simple: If there are no more unfilled spots (that is: no more 0s in the array), and no one hit a win condition, we declare it a draw!

### Win Condition Answer Keys are as follows:
Top left to bottom right diagonal:
[1, 0, 0, 0, 1, 0, 0, 0, 1]

Top right to bottom left diagonal:
[0, 0, 1, 0, 1, 0, 1, 0, 0]

Rows
[1, 1, 1, 0, 0, 0, 0, 0, 0]
[0, 0, 0, 1, 1, 1, 0, 0, 0]
[0, 0, 0, 0, 0, 0, 1, 1, 1]

Columns
[1, 0, 0, 1, 0, 0, 1, 0, 0]
[0, 1, 0, 0, 1, 0, 0, 1, 0]
[0, 0, 1, 0, 0, 1, 0, 0, 1]

Iteration can be simple: Go through the board array vs the answer key after each player's turn. Check that that player's number exists in a spot where an answer key "1" exists. 
Could be even easier, just an array of indices that are win conditions, then just check if they've hit those indices.

### Win Condition Indices:
Top left to bottom right diagonal:
[0, 4, 8]

Top right to bottom left diagonal:
[2, 4, 6]

Rows
[0, 1, 2]
[3, 4, 5]
[6, 7, 8]

Columns
[0, 3, 6]
[1, 4, 7]
[2, 5, 8]

Thus, after every play, check if the user who just played has a win condition based off these indices.

Alternative Draw condition: 
If 9 turns have finished and no one has won, a draw happens.

### Integrating with Flutter
I am new to Flutter, having just worked on the tutorials in the documentation a day before attempting this Tic-Tac-Toe creation.

I am pleasantly surprised to find the underlying Dart language to be very familiar coming from Javascript and knowing a small amount of TypeScript. 

The main challenges will be to figure out what Widgets will be the best for what I am trying to build. Luckily, flutter documentation is fantastic.

My first steps will be to create a Stateful "Board" widget that can display different colors based on a state list of integers. 

This will be a proof of concept and practice with the different but yet not-unfamiliar layout ideas.

My thoughts are that the Board will encapsulate a state and then have children that are the spots based on that state.

Board
--State: [array of board spot state]
  Spot[0]
  Spot[1]
  Spot[2]
  ...
  Spot[8]

The Spots will take in the spot state from the the board state as a parameter and it'll describe what to display.

After getting the spots to Generate based on input (nothing difficult), I struggle with the layout. I need to read up on the documentation some more.

Layout and Constraints in Flutter need to be thought of differently than other types of layouts and constraints. ...

I'll need to create a board that generates a constrained 3x3 square grid and have that be the board.

### Layouts
Layouts in Flutter is definitely a bit different than HTML/CSS style layout, but conceptually very similar. I just need to learn the various arguments for the Widget constructors. There is a learning curve for the layouts and I would like to learn more about the sizing and positioning of elements.

### Coding in Dart/Flutter
The tooling is fantastic, after just two days of working on this, I am learning quite a lot about Dart/Flutter just through the documentation in the editor. Coming from languages without strong typing, I did not find it particularly hard to have to type in the types. In fact, they certainly help with catching errors, which I appreciate.

### "Finishing"
I've gotten the basic tic tac toe functionality, with score counters, basically enough to play the pen and paper game without using up sheets of paper! Obviously much more could be implemented, especially a cleaner UI but as practice, I definitely have learned a lot. Moving on I will tidy up the metadata and icon and attempt to post this to the Play Store. I'll also be looking forward to seeing if I could work on iOS on my windows system.