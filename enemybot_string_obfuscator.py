import sys,zlib,ast,collections 
def escape(s):
    ch = (ord(c) for c in s)
    # %02: (U+0002) start of transmission
    # %04: (U+0004) end of transmission
    return ''.join(('\\x%02x' % c) if c <= 255 else ('\\u%04x' % c) for c in ch)
global newcode
code = newcode = open(sys.argv[1]).read()
root = ast.parse(code)
class ShowStrings(ast.NodeVisitor):
  def visit_Str(self, node):
    if len(node.s) >= 5 and "re." not in code.split("\n")[node.lineno-1] and ":(" not in code.split("\n")[node.lineno-1] and ": (" not in code.split("\n")[node.lineno-1]: #min length five and no regex statements or dicts allowed
            global newcode
            string=code.split("\n")[node.lineno-1][node.col_offset:node.col_offset+len(node.s)+2][0]+"".join(code.split("\n")[node.lineno-1][node.col_offset+1:node.col_offset+len(node.s)+len(code.split("\n")[node.lineno-1][node.col_offset-1:node.col_offset+len(node.s)+2].split(code.split("\n")[node.lineno-1][node.col_offset+1:node.col_offset+len(node.s)+2][0])[0])+4][:code.split("\n")[node.lineno-1][node.col_offset+1:node.col_offset+len(node.s)+len(code.split("\n")[node.lineno-1][node.col_offset-1:node.col_offset+len(node.s)+2].split(code.split("\n")[node.lineno-1][node.col_offset+1:node.col_offset+len(node.s)+2][0])[0])+4].find(code.split("\n")[node.lineno-1][node.col_offset:node.col_offset+len(node.s)+2][0])])+code.split("\n")[node.lineno-1][node.col_offset:node.col_offset+len(node.s)+2][0]
            compressed="zlib.decompress("+code.split("\n")[node.lineno-1][node.col_offset:node.col_offset+len(node.s)+2][0]+escape(zlib.compress(node.s))+code.split("\n")[node.lineno-1][node.col_offset:node.col_offset+len(node.s)+2][0]+")"
            newcode=newcode.replace(string, compressed)
ShowStrings().visit(root)
with open("secret.py", 'w') as f: f.write(newcode)