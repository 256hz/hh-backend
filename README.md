### [Live link](http://abes-helpful-demo.herokuapp.com)

Code challenge accepted.

### INSTALLATION

Clone & ```bundle```

This RESTful API was built on Rails 6.0 using Ruby 2.6.3 and a PostgreSQL DB.

### FUNCTIONS
- Root (`/`): returns all colors in JSON.
- `/generate/:amount`: add this many more random colors to the DB.

### COLOR FILTERING
I chose to filter the colors on creation, because it only needs to happen once, and this will lessen the load on the browser.  The method I used was pretty hand-coding intensive, because it turns out our mental map of colors doesn't correspond easily to numerical values.

I added the 'cyan' category to the original spec because otherwise the line between blue and green was too blurry.

Color generation happens like this:
- Generate 3-digit (6 character) random hex number.
- Parse that number into RGB values.
- 'Scale down' the RGB values so each number only goes from 0-6 (i.e. `[1, 4, 6]`).
- Iterate through the COLOR_ANCHORS array, which contains one hash per color category.  The hash's format is `color name: array of anchor colors`.  Check the distance from the anchor points to the RGB value.  Store the name of the color that's closest.
- Commit to database.

### SCHEMA
Color
- id:integer
- hex:string
- relative_color:string (this is the `[1, 4, 6]` number)
- family:string
- created_at / updated_at:datetime

### TESTING
Some preliminary unit tests have been added for the Color class.  These can be run with ```rspec```.  
