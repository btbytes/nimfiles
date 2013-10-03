# Source: https://gist.github.com/gradha/5555512
# Problem: http://saml.rilspace.org/calculating-gc-content-in-python-and-d-how-to-get-10x-speedup-in-d
#
# good example of file and string processing in nimrod
# nimrod c nimspeed.nim

import strutils

proc process(filename: string) =
  var
    input: TFile
    lineBuf = newString(100)
    gcCount = 0
    totalBaseCount = 0

  input = open(filename)
  finally: input.close()
  while input.readLine(lineBuf):
    if lineBuf[0] != '>':
      for letter in lineBuf:
        case letter
        of 'A':
          totalBaseCount += 1
        of 'C':
          gcCount += 1
          totalBaseCount += 1
        of 'G':
          gcCount += 1
          totalBaseCount += 1
        of 'T':
          totalBaseCount += 1
        else:
          nil

  let gcFraction = gcCount / totalBaseCount
  echo formatFloat(gcFraction * 100, ffDecimal, 4)


when isMainModule:
  process("/Users/pradeep/datasets/gc-content/Homo_sapiens.GRCh37.67.dna_rm.chromosome.Y.fa")
