//=============================================================================
// MoreBloodConfig
//=============================================================================
class MoreBloodConfig expands UWindowDialogClientWindow config(MoreBlood);

var UWindowHSliderControl slider;
var UWindowHSliderControl slider2;
var UWindowHSliderControl slider3;
var UWindowHSliderControl slider4;
var UWindowHSliderControl slider5;
var UWindowCheckBox checkbox1;
var UWindowCheckBox checkbox2;
var UWindowCheckBox checkbox3;
var UWindowSmallButton CloseButton;
var UWindowSmallCloseButton CancelButton;
var UWindowEditControl adjbotEditBox;
var UWindowEditControl adjbotEditBox2;
var UWindowEditControl adjbotEditBox3;
var UWindowEditControl adjbotEditBox4;
var UWindowEditControl adjbotEditBox5;
var string L;
var bool bInit;

//MoreBlood setup variables
var() config bool bRandomMode;
var() config bool bBloodPool;
var() config bool bDeathEffect;
var() config int MaxBleeders;
var() config float BleedTime;
var() config float BDLifeSpan;
var() config float BDDrawScale;
var() config float SpurtLevel;
var() config int MaxBleedersRV;
var() config float BleedTimeRV;
var() config float BDLifeSpanRV;
var() config float BDDrawScaleRV;
var() config float SpurtLevelRV;
var() config float SpawnRate;
var() config int MBdefHealth;

function Created()
{	
	Super.Created();
	
	slider = UWindowHSliderControl(CreateControl(class'UWindowHSliderControl', 20, 15, 350, 1));
	slider.SetText("Maximum Bleeders per Pawn: ");
	slider.SetRange(1,80,1);
	if (MaxBleedersRV > 80)
		slider.SetValue(80);
	else
		slider.SetValue(MaxBleedersRV);
	adjbotEditBox = UWindowEditControl(CreateWindow(class'UWindowEditControl', 20, 30, 350, WinHeight-30));
	adjbotEditBox.Align = TA_Left;
	adjbotEditBox.SetText("Recommended range: 2 - 20       Enter values or use sliders to adjust");
	adjbotEditBox.SetValue(Left(string(MaxBleedersRV), 3));
	adjbotEditBox.SetNumericOnly(False);
	adjbotEditBox.EditBoxWidth = 32;

	slider2 = UWindowHSliderControl(CreateControl(class'UWindowHSliderControl', 20, 60, 350, 1));
	slider2.SetText("Duration of bleeding effects: ");
	slider2.SetRange(0.125,80.0,0.1);
	if (BleedTimeRV > 80.0)
		slider2.SetValue(80.0);
	else
		slider2.SetValue(BleedTimeRV);
	
	adjbotEditBox2 = UWindowEditControl(CreateWindow(class'UWindowEditControl', 20, 75, 350, WinHeight-30));
	adjbotEditBox2.Align = TA_Left;
	adjbotEditBox2.SetText("Recommended range: 0.5 - 20.0         *Drag to adjust by fractions");
	adjbotEditBox2.SetValue(Left(string(BleedTimeRV), 4));
	adjbotEditBox2.SetNumericOnly(False);
	adjbotEditBox2.EditBoxWidth = 32;

	slider3 = UWindowHSliderControl(CreateControl(class'UWindowHSliderControl', 20, 105, 350, 1));
	slider3.SetText("BloodDrop lifepan: ");
	slider3.SetRange(0.0125,255,0.1);
	if (BDLifeSpanRV > 255)
		slider3.SetValue(255);
	else
		slider3.SetValue(BDLifeSpanRV);
	
	adjbotEditBox3 = UWindowEditControl(CreateWindow(class'UWindowEditControl', 20, 120, 350, WinHeight-30));
	adjbotEditBox3.Align = TA_Left;
	adjbotEditBox3.SetText("Recommended range: 25 - 80");
	adjbotEditBox3.SetNumericOnly(False);
	adjbotEditBox3.EditBoxWidth = 32;
	adjbotEditBox3.SetValue(Left(string(BDLifeSpanRV), 4));

	slider4 = UWindowHSliderControl(CreateControl(class'UWindowHSliderControl', 20, 150, 350, 1));
	slider4.SetText("BloodDrop draw scale: ");
	slider4.SetRange(0.0125,1.0,0.01);
	if (BDDrawScaleRV > 1)
		slider4.SetValue(1);
	else
		slider4.SetValue(BDDrawScaleRV);
	
	adjbotEditBox4 = UWindowEditControl(CreateWindow(class'UWindowEditControl', 20, 165, 350, WinHeight-30));
	adjbotEditBox4.Align = TA_Left;
	adjbotEditBox4.SetText("Recommended range: 0.025 - 0.60");
	adjbotEditBox4.SetNumericOnly(False);
	adjbotEditBox4.EditBoxWidth = 32;
	adjbotEditBox4.SetValue(Left(string(BDDrawScaleRV), 5));

	slider5 = UWindowHSliderControl(CreateControl(class'UWindowHSliderControl', 20, 195, 350, 1));
	slider5.SetText("SpurtLevel: ");
	slider5.SetRange(1,255,1);
	if (SpurtLevelRV > 255)
		slider5.SetValue(255);
	else
		slider5.SetValue(SpurtLevelRV);
	
	adjbotEditBox5 = UWindowEditControl(CreateWindow(class'UWindowEditControl', 20, 210, 350, WinHeight-30));
	adjbotEditBox5.Align = TA_Left;
	adjbotEditBox5.SetText("Recommended range: 5 - 128");
	adjbotEditBox5.SetValue(Left(string(SpurtLevelRV), 3));
	adjbotEditBox5.SetNumericOnly(True);
	adjbotEditBox5.EditBoxWidth = 32;


	checkbox1 = UWindowCheckBox(CreateControl(class'UWindowCheckBox', 20, 250, 178, 1));
	checkbox1.SetText("Random Mode: ");
	checkbox1.bChecked = bRandomMode;

	checkbox2 = UWindowCheckBox(CreateControl(class'UWindowCheckBox', 20, 270, 178, 1));
	checkbox2.SetText("Use BloodPools: ");
	checkbox2.bChecked = bBloodPool;

	checkbox3 = UWindowCheckBox(CreateControl(class'UWindowCheckBox', 20, 290, 178, 1));
	checkbox3.SetText("Use DeathEffect: ");
	checkbox3.bChecked = bDeathEffect;

	// Update button 
	CloseButton = UWindowSmallButton(CreateWindow(class'UWindowSmallButton', 275 , 275, 48, 16));
	CloseButton.SetText( "Update" );
	CloseButton.NotifyWindow = Self; // doesn't seem to work otherwise.

	// Cancel button
	CancelButton = UWindowSmallCloseButton(CreateWindow(class'UWindowSmallCloseButton', 275, 305, 48, 16));
	CancelButton.SetText( "Cancel" );	
}

//when a control changes, Notify is called with the changed control
function Notify(UWindowDialogControl C, byte E)
{
	local float sval;
	local int sival;

	Super.Notify( C, E );

	if (checkbox1 != None)
	switch(E)
	{
	case DE_Change: // the message sent by sliders and checkboxes 
	switch(C)
	{	
		case slider:
			sival =  slider.GetValue(); sval = sival;
			adjbotEditBox.SetValue(Left(string(sival), 3));
			MaxBleedersRV = sval;
			break;		
		case slider2:
			sval =  slider2.GetValue();
			adjbotEditBox2.SetValue(Left(string(sval), 4));
			BleedTimeRV = sval;
			break;		
		case slider3:
			sval =  slider3.GetValue();
			BDLifeSpanRV = sval;
			adjbotEditBox3.SetValue(Left(string(BDLifeSpanRV), 4));
			break;		
		case slider4:
			sval =  slider4.GetValue();
			BDDrawScaleRV = sval;
			adjbotEditBox4.SetValue(Left(string(BDDrawScaleRV), 5));
			break;		
		case slider5:
			sval =  slider5.GetValue();
			SpurtLevelRV = sval;
			adjbotEditBox5.SetValue(Left(string(SpurtLevelRV), 3));
			break;		
		case checkbox1:
			if (checkbox1.bChecked) 
				bRandomMode = True;
			else
				bRandomMode = False;
			break;						
		case checkbox2:
			if (checkbox2.bChecked) 
				bBloodPool = True;
			else
				bBloodPool = False;
			break;						
		case checkbox3:
			if (checkbox3.bChecked) 
				bDeathEffect = True;
			else
				bDeathEffect = False;
			break;						
	}
	case DE_Click:
	switch(C)
		{		
			case CloseButton:
				sval = float(adjbotEditBox.GetValue());
				MaxBleeders = sval; MaxBleedersRV = sval;
				sval = float(adjbotEditBox2.GetValue());
				BleedTime = sval; BleedTimeRV = sval;
				sval = float(adjbotEditBox3.GetValue());
				BDLifeSpan = sval; BDLifeSpanRV = sval;
				sval = float(adjbotEditBox4.GetValue());
				BDDrawScale = sval; BDDrawScaleRV = sval;
				sval = float(adjbotEditBox5.GetValue());
				SpurtLevel = sval; SpurtLevelRV = sval;
				SaveConfig();
				ParentWindow.Close();
			break;
		}
	break;
	}
}

defaultproperties
{
	bRandomMode=True
	bBloodPool=True
	bDeathEffect=False
	MaxBleeders=5
	BleedTime=2.50
	BDLifeSpan=25.0
	BDDrawScale=0.25000
	SpurtLevel=32
	MaxBleedersRV=15
	BleedTimeRV=10.0
	BDLifeSpanRV=48.0
	BDDrawScaleRV=0.35000
	SpurtLevelRV=48
	SpawnRate=0.25
	MBdefHealth=100
}
