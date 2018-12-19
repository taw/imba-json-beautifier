let stringify = require("json-stringify-pretty-compact")

tag App
  def setup
    @maxlen = 80
    @indent = 2
    @text = JSON.stringify({hello: "world"})

  def prettify
    let json = JSON.parse(@text)
    let spaces = Array.from({length: @indent+1}).join(" ")
    @text = stringify(json, {maxLength: @maxlen, indent: spaces})

  def render
    <self>
      <header>
        "JSON Beautifier"
      <textarea[@text] rows=10>
      <div.controls>
        <label for="indent">
          "Indent"
        <input#indent[@indent] type="number" min=0>
        <label for="maxlen">
          "Max row length"
        <input#maxlen[@maxlen] type="number" min=0>
        <button :click.prettify>
          "Prettify"

Imba.mount <App>
