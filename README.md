# Testimator

## Inspiration
While brainstorming on how we can help students, something that came up often was studying for tests. There are plenty of programs out there that allow you to manage study time in various ways, although none that we found actually tell you how much you should study. We decided to tackle this by combining our statistical and coding knowledge to create a "personalized study curve" for the user.

## What it does
Testimator uses past test data for each subject (study time and mark) and a logarithmic regression to create a mathematical model. The reason we chose a logarithmic regression is because the effectiveness of studying decreases the more you study. The equation of the function for each subject is then used to predict the amount of study time needed to get a certain mark in that subject.

## How we built it
The algorithm for logarithmic regression is built using formulas we found on a website. Using Processing, visual elements of the program are easily attainable. Information about subjects and past tests are stored and extracted via .txt files.

## Challenges we ran into
At the start, we struggled to find a platform to live-edit code that is compatible with Processing. We ended up using GitHub to share code and merge different people's progress manually. Finding formulas for the regression and converting it into code was difficult, but in the end we were able to find a reliable metric. There were also some problems with procrastination and division of work, but we were able to overcome them and work efficiently afterward.

## Accomplishments that we're proud of
We are most happy that, despite the difficulties, we were able to make every feature we initially wanted to add. We are also proud of our simplistic and intuitive GUI and the fact that we've successfully combined our knowledge from statistics and computer science.

## What we learned
We've learned the importance of time management (which is ironic considering what we made), how having a good way to collaborate is just as important as having good programmers, and how dividing work is much more efficient.

## What's next for Testimator
Throughout the coding process, we wanted to implement some features that we didn't have time for. These include but are not limited to: 1. Study efficiency calculator, 2. Suggestion on when to study, 3. Project organizer.
