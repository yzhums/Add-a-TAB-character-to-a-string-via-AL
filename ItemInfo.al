report 50112 "Item Info"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = RDLC;

    dataset
    {
        dataitem(Item; Item)
        {
            column(No_; "No.")
            {
            }
            column(Base_Unit_of_Measure; "Base Unit of Measure")
            {
            }
            column(Inventory; Inventory)
            {
            }
            column(QRCode; QRCode)
            {
            }
            trigger OnAfterGetRecord()
            begin
                GenerateQRCode();
            end;
        }
    }

    rendering
    {
        layout(RDLC)
        {
            Type = RDLC;
            LayoutFile = 'ItemInfo.rdl';
        }
    }

    var
        QRCode: Text;

    local procedure GenerateQRCode()
    var
        BarcodeSymbology2D: Enum "Barcode Symbology 2D";
        BarcodeFontProvider2D: Interface "Barcode Font Provider 2D";
        BarcodeString: Text;
        TabChar: Char;
    begin
        TabChar := 9;
        BarcodeFontProvider2D := Enum::"Barcode Font Provider 2D"::IDAutomation2D;
        BarcodeSymbology2D := Enum::"Barcode Symbology 2D"::"QR-Code";
        BarcodeString := Item."No." + TabChar + Item."Base Unit of Measure" + TabChar + Format(Item.Inventory);
        QRCode := BarcodeFontProvider2D.EncodeFont(BarcodeString, BarcodeSymbology2D);
    end;
}
