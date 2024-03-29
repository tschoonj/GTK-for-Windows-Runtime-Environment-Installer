��          �            x     y     �     �     �     �  I   �          )     5     A  �   M  )   �    
      $  $  z  I     �     �     �     �     �  I        g          �     �  �   �  1   b  �  �  �  T  y  1                                           
       	                             	. Codabar
 	. Code 128
 	. Code 39
 	. Code 93
 	. DataBar, DataBar Expanded
 	. EAN/UPC (EAN-13, EAN-8, EAN-2, EAN-5, UPC-A, UPC-E, ISBN-10, ISBN-13)
 	. Interleaved 2 of 5
 	. PDF 417
 	. QR code
 	. SQ code
 
WARNING: barcode data was not detected in some image(s)
Things to check:
  - is the barcode type supported? Currently supported symbologies are:
     --nodbus        disable dbus message
   - is the barcode large enough in the image?
  - is the barcode mostly in focus?
  - is there sufficient contrast/illumination?
  - If the symbol is split in several barcodes, are they combined in one image?
  - Did you enable the barcode type?
    some EAN/UPC codes are disabled by default. To enable all, use:
    $ zbarimg -S*.enable <files>
    Please also notice that some variants take precedence over others.
    Due to that, if you want, for example, ISBN-10, you should do:
    $ zbarimg -Sisbn10.enable <files>

 usage: zbarcam [options] [/dev/video?]

scan and decode bar codes from a video stream

options:
    -h, --help      display this help text
    --version       display version information and exit
    -q, --quiet     disable beep when symbol is decoded
    -v, --verbose   increase debug output level
    --verbose=N     set specific debug output level
    --xml           use XML output format
    --raw           output decoded symbol data without converting charsets
    -1, --oneshot   exit after scanning one bar code
    --nodisplay     disable video display window
    --prescale=<W>x<H>
                    request alternate video image size from driver
    -S<CONFIG>[=<VALUE>], --set <CONFIG>[=<VALUE>]
                    set decoder/scanner <CONFIG> to <VALUE> (or 1)

 usage: zbarimg [options] <image>...

scan and decode bar codes from one or more image files

options:
    -h, --help      display this help text
    --version       display version information and exit
    -q, --quiet     minimal output, only print decoded symbol data
    -v, --verbose   increase debug output level
    --verbose=N     set specific debug output level
    -d, --display   enable display of following images to the screen
    -D, --nodisplay disable display of following images (default)
    --xml, --noxml  enable/disable XML output format
    --raw           output decoded symbol data without converting charsets
    -1, --oneshot   exit after scanning one bar code
    -S<CONFIG>[=<VALUE>], --set <CONFIG>[=<VALUE>]
                    set decoder/scanner <CONFIG> to <VALUE> (or 1)

 Project-Id-Version: zbar 0.23
Report-Msgid-Bugs-To: https://github.com/mchehab/zbar/issues
POT-Creation-Date: 2020-04-13 10:36+0200
PO-Revision-Date: 2020-04-12 17:01+0200
Last-Translator: 
Language-Team: 
Language: pt_BR
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Generator: Poedit 2.3
Plural-Forms: nplurals=2; plural=(n > 1);
 	. Codabar
 	. Código 128
 	. Código 39
 	. Código 93
 	. DataBar, DataBar Expandido
 	. EAN/UPC (EAN-13, EAN-8, EAN-2, EAN-5, UPC-A, UPC-E, ISBN-10, ISBN-13)
 	. Entrelaçado 2 de 5
 	. PDF 417
 	. Código QR
 	. Código SQ
 
AVISO: dados de código de barra não foram decodificados em alguma(s) imagem(ns)
Favor verificar:
  - Há suporte para códigos de barras desse tipo? As simbologias suportadas são:
     --nodbus        desabilita mensagens no dbus
   - O código de barras ficou grande o suficiente na foto?
  - O código de barras está em foco?
  - Existe iluminação e contraste suficientes?
  - Se o símbolo está dividido em diversos códigos, eles foram combinados em uma única imagem?
  - O tipo de código de barras está habilitado?
    Alguns códigos EAN/UPC são desabilitados por padrão. Para habilitar todos, use:
    $ zbarimg -S*.enable <files>
    Note também que algumas variantes são utilizadas primeiro, quando é possível decodificar o mesmo código com múltiplas variantes.
    Por conta disso, se você desejar, por exemplo, utilizar ISBN-10, você deve habilitar a simbologia com:
    $ zbarimg -Sisbn10.enable <files>

 uso: zbarcam [opções] [/dev/video?]

Lê e decodifica códigos de barra em imagens capturadas pela câmera ou outro dispositivo de vídeo

opções:
    -h, --help      esse texto de auxílio
    --version       mostra a versão e termina
    -q, --quiet     desabilita mensagens informativas e avisos sonoros quando símbolos são decodificados
    -v, --verbose   aumenta o nível de mensagens de depuração
    --verbose=N     configura um determinado nível de mensagens de depuração
    --xml           mostra resultados em formato XML
    --raw           mostra símbolos decodificados sem metadados e sem converter o conjunto de caracteres
    -1, --oneshot   termina o programa após ler um código de barras
    --nodisplay     desabilita janela de apresentação de imagens
    --prescale=<W>x<H>
                    solicita modo de vídeo diferente
    -S<CONFIG>[=<VALUE>], --set <CONFIG>[=<VALUE>]
                    configura parâmetro <CONFIG> para <VALUE> (ou 1)

 uso: zbarimg [opções] <image>...

Lê e decodifica códigos de barra em uma ou mais imagens

opções:
    -h, --help      esse texto de auxílio
    --version       mostra a versão e termina
    -q, --quiet     desabilita mensagens informativas
    -v, --verbose   aumenta o nível de mensagens de depuração
    --verbose=N     configura um determinado nível de mensagens de depuração
    --xml           mostra resultados em formato XML
    --raw           mostra símbolos decodificados sem metadados e sem converter o conjunto de caracteres
    -1, --oneshot   termina o programa após ler um código de barras
    --nodisplay     desabilita janela de apresentação de imagens
    --prescale=<W>x<H>
                    solicita modo de vídeo diferente
    -S<CONFIG>[=<VALUE>], --set <CONFIG>[=<VALUE>]
                    configura parâmetro <CONFIG> para <VALUE> (ou 1)

 