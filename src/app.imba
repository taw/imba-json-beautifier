let stringify = require("json-stringify-pretty-compact")

tag App
  def setup
    @maxlen = 80
    @indent = 2
    @text = JSON.stringify({hello: "world"})
    @error = null

  def prettify
    try
      let indent = parseInt(@indent)
      let json = JSON.parse(@text)
      let spaces = Array.from({length: indent+1}).join(" ")
      @text = stringify(json, {maxLength: @maxlen, indent: spaces})
    catch e
      @error = e

  def clear_error
    @error = null

  def upload(event)
    let file = event.native:target:files[0]
    return unless file
    let reader = FileReader.new

    reader:onload = do |event|
      @text = event:target:result
      @error = nil
      Imba.commit
    reader.read-as-text(file)

  def render
    <self>
      <header>
        "JSON Beautifier"
      <textarea[@text] rows=10 :input.clear_error>
      if @error
        <div.error>
          @error
      <div.controls>
        <label for="indent">
          "Indent"
        <input#file type="file" :change.upload>
        <input#indent[@indent] type="number" min=0>
        <label for="maxlen">
          "Max row length"
        <input#maxlen[@maxlen] type="number" min=0>
        <button :click.prettify>
          "Prettify"

Imba.mount <App>
