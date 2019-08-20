# HTML Analyzer

## Requirements

```Ruby 2.6.0```

## Setup

```gem install bundler```
```bundle install```

## Execute app

```ruby html_analyzer.rb <input_origin_file_path> <input_other_sample_file_path>```

## Results output

- sample-1-evil-gemini.html

```
/html/body/div/div/div[3]/div[1]/div/div[2]/a[2]

Element's text matched
Attr 'class' with value 'btn btn-success' matched
Attr 'title' with value 'Make-Button' matched
Attr 'onclick' with value 'javascript:window.okDone(); return false;' matched
```

- sample-2-container-and-clone.html

```
/html/body/div/div/div[3]/div[1]/div/div[2]/div/a

Element's text matched
Attr 'href' with value '#ok' matched
Attr 'title' with value 'Make-Button' matched
Attr 'rel' with value 'next' matched
```

- sample-3-the-escape.html
```
/html/body/div/div/div[3]/div[1]/div/div[3]/a

Attr 'class' with value 'btn btn-success' matched
Attr 'href' with value '#ok' matched
Attr 'rel' with value 'next' matched
Attr 'onclick' with value 'javascript:window.okDone(); return false;' matched
```

- sample-4-the-mash.html

```
/html/body/div/div/div[3]/div[1]/div/div[3]/a

Attr 'class' with value 'btn btn-success' matched
Attr 'href' with value '#ok' matched
Attr 'title' with value 'Make-Button' matched
Attr 'rel' with value 'next' matched
```