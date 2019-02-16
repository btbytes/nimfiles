#[
downthemall.nim

Download documents matching a pattern from a webpage.

Build:
  nim c -r -d:ssl -d:release downthemall.nim


Example: (downloads all the PDFs linked in the URL)
  ./downthemall https://www.btbytes.com/pl.html -A .pdf
]#

import htmlparser
import httpclient
import xmltree
import strtabs
import os
import strutils
import streams
import parseopt

when isMainModule:
  var url: string
  var extns: seq[string]
  for kind, key, val in getopt():
    case kind
    of cmdArgument:
      url = key
    of cmdShortOption:
      case key
      of "A": extns.add(val)
    of cmdLongOption: discard
    of cmdEnd: discard

  if url == "" or extns == @[]:
    echo "usage: downthemall URL -A .extension [-A .another]"
    quit(0)


  let client = newHttpClient()
  let content = client.getContent(url)
  let html = parseHtml(newStringStream(content))
  for a in html.findall("a"):
    let href = a.attrs["href"]
    for extn in extns:
      if href.endswith(extn):
        let fname = href.split('/')[^1]
        downloadFile(href, fname)
        echo "Downloaded: $1 to $2" % [href, fname]
