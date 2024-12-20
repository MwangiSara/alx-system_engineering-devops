# Regular Expressions (Regex)

Regular expressions, often abbreviated as regex or regexp, are powerful tools for pattern matching and text manipulation. They provide a way to search for, match, and manipulate text based on patterns.

## Basics

- **Literal Characters**: Match characters exactly as they appear in the pattern.
- **Metacharacters**: Special characters with a specific meaning in regex, such as `.`, `*`, `+`, `?`, `[`, `]`, `^`, `$`, `\`, etc.
- **Quantifiers**: Specify the number of occurrences of a character or group, such as `*` (zero or more), `+` (one or more), `?` (zero or one), `{n}` (exactly n times), `{n,}` (at least n times), `{n,m}` (between n and m times).
- **Character Classes**: Define a set of characters to match within square brackets, such as `[abc]` (matches a, b, or c).
- **Anchors**: Specify where in the text the pattern should match, such as `^` (start of line), `$` (end of line), `\b` (word boundary).
- **Grouping and Capturing**: Use parentheses to group characters or expressions together, and to capture matched text for later use.
- **Alternation**: Use the pipe symbol `|` to specify multiple alternatives.
- **Lookahead and Lookbehind**: Zero-width assertions that specify conditions without including them in the match itself.

## Usage

Regular expressions are commonly used in various programming languages, text editors, and command-line tools for tasks such as:
- Searching and replacing text
- Validating input data
- Extracting information from text
- Parsing and analyzing logs or structured data
- Data cleaning and transformation
- URL routing and request handling in web applications

## Resources

Learning regular expressions can be challenging but rewarding. Here are some helpful resources to get started:
- [Regex101](https://regex101.com/): An online regex tester and debugger.
- [Regular-Expressions.info](https://www.regular-expressions.info/): A comprehensive tutorial and reference guide.
- [MDN Web Docs - Regular Expressions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions): Mozilla Developer Network's documentation on regular expressions in JavaScript.
- Books: "Mastering Regular Expressions" by Jeffrey Friedl and "Regular Expressions Cookbook" by Jan Goyvaerts and Steven Levithan.

