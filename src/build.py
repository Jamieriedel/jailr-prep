"""Baut die App nach dist/index.html (oder an den angegebenen Ort) und die Umzugsseite der alten Adresse nach index.html."""
import base64,hashlib,json,re,sys,os
def csp(s,connect):
    m=re.search(r'<script>(.*?)</script>',s,re.S); h=base64.b64encode(hashlib.sha256(m.group(1).encode()).digest()).decode()
    assert len(re.findall(r'<script',s))==1
    return s.replace('<!--CSP-->',f"<meta http-equiv=\"Content-Security-Policy\" content=\"default-src 'none'; script-src 'sha256-{h}'; style-src 'unsafe-inline'; font-src data:; img-src 'self' data: blob:; media-src blob:; connect-src {connect}; worker-src 'none'; object-src 'none'; base-uri 'none'; form-action 'none'\">")
s=open('src/src.html').read()
s=s.replace('__FONT__',base64.b64encode(open('src/space-grotesk-latin-wght-normal.woff2','rb').read()).decode())
cfg=json.load(open(os.environ.get('JAILR_CONFIG','src/config.json')))
s=csp(s.replace('__CONFIG__',json.dumps(cfg)),cfg['api'] or "'none'")
out=sys.argv[1] if len(sys.argv)>1 else 'dist/index.html'
os.makedirs(os.path.dirname(out) or '.',exist_ok=True)
open(out,'w').write(s);print('built',out,len(s)//1024,'KB')
if len(sys.argv)<2:
    open('index.html','w').write(csp(open('src/umzug.html').read(),"'none'"));print('built index.html (Umzug)')
