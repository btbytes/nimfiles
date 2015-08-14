# Uses strutils.count

# This is slower than nimspeed because we read the body of the
# file four times compared to once in `nimspeed.nim`.

# The solution is shorter, but takes longer to run ;)


import strutils

proc process(fname: string) =
    let body = readFile(fname)
    let a = body.count('A')
    let c = body.count('C')
    let g = body.count('G')
    let t = body.count('T')
    let totalBaseCount = a + c + g + t
    let gcCount = g+c
    let gcFraction = gcCount / totalBaseCount
    echo formatFloat(gcFraction*100, ffDecimal, 4)

when isMainModule:
    process("/Users/pradeep/datasets/gc-content/Homo_sapiens.GRCh37.67.dna_rm.chromosome.Y.fa")
