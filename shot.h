#ifndef SHOT_H
#define SHOT_H

#include <QObject>
#include <QQuickItem>
#include<QDebug>
#include <stdio.h>
#include <stdlib.h>
#include<QGuiApplication>
#include<QDateTime>
#include<QScreen>
#include<QPixmap>
#include "QZXing.h"
class Shot: public QObject
{
    Q_OBJECT
public:
    Shot();
    QZXing zxing;
    QString decode(QImage qrImage);
    Q_INVOKABLE  QString shot(int x0,int y0,int x1,int y1);
};

#endif // SHOT_H
