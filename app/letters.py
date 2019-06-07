import string

# result = [string.ascii_lowercase]
# data = "g fmnc wms bgblr rpylqjyrc gr zw fylb. rfyrq ufyr amknsrcpq ypc dmp. bmgle gr gl zw fylb gq glcddgagclr ylb rfyr'q ufw rfgq rcvr gq qm jmle. sqgle qrpgle.kyicrpylq() gq pcamkkclbcb. lmu ynnjw ml rfc spj."
# ans= str()
# print(result[0])
# for i in data:
#     ans+= chr(ord(i) + 2)
# print(ans)


raw = "e:eg9:9>"

table = str.maketrans(
    "abcdefghijklmnopqrstuvwxyz", "cdefghijklmnopqrstuvwxyzab"
)

result = raw.translate(table)

print ([chr(i) for i in xrange(127)])