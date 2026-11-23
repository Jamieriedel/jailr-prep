import base64,hashlib,json,re,sys,os
s=open('src/src.html').read()
font=base64.b64encode(open('src/space-grotesk-latin-wght-normal.woff2','rb').read()).decode()
s=s.replace('__FONT__',font)
cfg=json.load(open(os.environ.get('JAILR_CONFIG','src/config.json')))
s=s.replace('__CONFIG__',json.dumps(cfg))
m=re.search(r'<script>(.*?)</script>',s,re.S); h=base64.b64encode(hashlib.sha256(m.group(1).encode()).digest()).decode()
csp=f"default-src 'none'; script-src 'sha256-{h}'; style-src 'unsafe-inline'; font-src data:; img-src 'self' data: blob:; media-src blob:; connect-src {cfg['api'] if cfg['api'] else chr(39)+'none'+chr(39)}; worker-src 'none'; object-src 'none'; base-uri 'none'; form-action 'none'"
s=s.replace('<!--CSP-->',f'<meta http-equiv="Content-Security-Policy" content="{csp}">')
assert len(re.findall(r'<script',s))==1
open(sys.argv[1] if len(sys.argv)>1 else 'index.html','w').write(s);print('built',len(s)//1024,'KB')
