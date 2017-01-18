" KK's VimSay Plugin.
" Last Change: 2016-9-18
" Maintainer: bxtkezhan-kk <bxtkezhan@gmail.com>
" License: use the GPL license.

if exists('loaded_vs')
    finish
endif
let loaded_vsl = 1
command! VSC call VimSayRange()
command! -range VSR <line1>,<line2>call VimSayRange()

function! VimSayRange() range
    call VimSayLines(a:firstline-1, a:lastline) 
endfunction

function! VimSayLines(firstLine, lastLine)
py3 <<EOF
import vim
from urllib.request import Request, urlopen
from urllib.parse import urlencode, quote
from urllib.error import HTTPError, URLError
from os import path, system


tok_params = {
    'client_id': vim.eval('g:vs_client_id'),
    'client_secret': vim.eval('g:vs_client_secret'),
}

_, colm = vim.current.window.cursor
firline = int(vim.eval('a:firstLine'))
lasline = int(vim.eval('a:lastLine'))
tex_lis = vim.current.buffer[firline:lasline]
tex_str = '\n'.join(tex_lis).encode('utf-8')[colm:]
# print(tex_str.decode('utf-8'))

tmp_path = '/tmp'


def get_tok(data):
    url = 'https://openapi.baidu.com/oauth/2.0/token'
    data['grant_type'] = 'client_credentials'
    data_encoded = urlencode(data).encode('utf-8')
    try:
        req = Request(url, data=data_encoded)
        rsp = urlopen(req, timeout=5).read().decode('utf-8')
    except (HTTPError, URLError) as e:
        # print(e)
        return None
    except Exception as e:
        # print(e)
        return None
    import json
    return json.loads(rsp)['access_token']


def get_audio(data):
    url = 'http://tsn.baidu.com/text2audio'
    data_encoded = urlencode(data).encode('utf-8')
    try:
        req = Request(url, data=data_encoded)
        rsp = urlopen(req, timeout=5)
    except (HTTPError, URLError) as e:
        # print(e)
        return None
    except Exception as e:
        # print(e)
        return None
    if rsp.getheader('Content-Type') != 'audio/mp3':
        # print(rsp.read().encode('utf-8'))
        return None
    return rsp.read()

def main():
    tok = get_tok(tok_params)
    # print(tok)

    if tok is None: return None
    aud_params = {
        'tex': tex_str,
        'tok': tok,
        'cuid': vim.eval('g:vs_cuid'),
        'lan': vim.eval('g:vs_lan'),
        'ctp': vim.eval('g:vs_ctp'),
        'spd': vim.eval('g:vs_spd'),
        'pit': vim.eval('g:vs_pit'),
        'vol': vim.eval('g:vs_vol'),
    }
    rsp = get_audio(aud_params)
    # print(rsp)

    if rsp is None: return None
    sound_file = path.join(tmp_path, 'vs_tmp.mp3')
    with open(sound_file, 'wb') as f:
        f.write(rsp)
    system(' '.join(['play', sound_file, '-q', '&']))
    return True


if __name__ == '__main__':
    for i in range(5):
        if main(): break
EOF
endfunction
