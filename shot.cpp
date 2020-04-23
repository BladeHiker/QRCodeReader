#include "shot.h"

Shot::Shot()
{
    zxing.setDecoder( QZXing::DecoderFormat_QR_CODE );
}
QString Shot::decode(QImage qrImage)
{
    const QString & decodeText = zxing.decodeImage( qrImage );
    return decodeText;
}
Q_INVOKABLE  QString Shot::shot(int x0,int y0,int x1,int y1){
    QRect rect(x0,y0,x0+x1,y0+y1);
    QScreen *screen = QGuiApplication::primaryScreen();
    QString str=decode( screen->grabWindow(0,x0,y0,x1,y1).toImage());
    return str;
}
