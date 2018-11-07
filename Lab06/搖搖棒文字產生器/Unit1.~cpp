//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
int x,y;
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button1Click(TObject *Sender)
{
        TColor color;
        int x1,y1;
        String bit;
        Image1->Picture=NULL;
        Image1->Canvas->Font->Size=StrToInt(ComboBox1->Text);
        Image1->Canvas->Font->Name=ComboBox2->Text;
        Image1->Canvas->TextOutA(x,y,Edit2->Text);
        //x1=StrToInt(Edit4->Text);
        //y1=StrToInt(Edit5->Text);
        RichEdit1->Clear();
        for (int i=0;i<24;i++)
                for(int j=23;j>=0;j--)
                {
                        color=Image1->Canvas->Pixels[i][j];
                        if(color==0xFFFFFF)
                        {
                                bit="0";
                        }
                        else
                        {
                                bit="1";
                        }
                        if(j==23)
                        {
                                RichEdit1->Text=RichEdit1->Text+"        DB      ";
                        }
                        else if(j==8||j==16)
                        {
                                RichEdit1->Text=RichEdit1->Text+bit+"B,";
                        }
                        else if(j==0)
                        {
                                RichEdit1->Text=RichEdit1->Text+bit+"B\r\n";
                        }
                        else
                        {
                                RichEdit1->Text=RichEdit1->Text+bit;
                        }
                        //RichEdit1->Text=RichEdit1->Text+IntToStr(b)+" "+IntToStr(g)+" "+IntToStr(r)+"\r\n";
                }

}
//---------------------------------------------------------------------------

void __fastcall TForm1::Edit1Change(TObject *Sender)
{
        x=StrToInt(Edit1->Text);
}
//---------------------------------------------------------------------------


void __fastcall TForm1::Edit3Change(TObject *Sender)
{
        y=StrToInt(Edit3->Text);
}
//---------------------------------------------------------------------------
void __fastcall TForm1::FormCreate(TObject *Sender)
{
        RichEdit1->Text="TABLE";
        Image1->Canvas->Font->Size=18;
        Image1->Canvas->Font->Name="º–∑¢≈È";
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Button2Click(TObject *Sender)
{
        exit(1);
}
//---------------------------------------------------------------------------
