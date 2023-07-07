// Copyright (c) 2023 Orange. All rights reserved.
// This software is distributed under the BSD 3-Clause-clear License, the text of which is available
// at https://spdx.org/licenses/BSD-3-Clause-Clear.html or see the "LICENSE" file for more details.

////////////////////////////////////////////////////////////
// File generated with Genere tool
// Insert your specific code inside "//## " sections

#include "KWAttributeAxisNameArrayView.h"

KWAttributeAxisNameArrayView::KWAttributeAxisNameArrayView()
{
	SetIdentifier("Array.KWAttributeAxisName");
	SetLabel("Variable axiss");
	AddStringField("AttributeName", "Attribute name", "");
	AddStringField("OwnerAttributeName", "Owner attribute name", "");

	// Card and help prameters
	SetItemView(new KWAttributeAxisNameView);
	CopyCardHelpTexts();

	// ## Custom constructor

	nMaxAxisNumber = 0;

	// ##
}

KWAttributeAxisNameArrayView::~KWAttributeAxisNameArrayView()
{
	// ## Custom destructor

	// ##
}

Object* KWAttributeAxisNameArrayView::EventNew()
{
	return new KWAttributeAxisName;
}

void KWAttributeAxisNameArrayView::EventUpdate(Object* object)
{
	KWAttributeAxisName* editedObject;

	require(object != NULL);

	editedObject = cast(KWAttributeAxisName*, object);
	editedObject->SetAttributeName(GetStringValueAt("AttributeName"));
	editedObject->SetOwnerAttributeName(GetStringValueAt("OwnerAttributeName"));

	// ## Custom update

	// ##
}

void KWAttributeAxisNameArrayView::EventRefresh(Object* object)
{
	KWAttributeAxisName* editedObject;

	require(object != NULL);

	editedObject = cast(KWAttributeAxisName*, object);
	SetStringValueAt("AttributeName", editedObject->GetAttributeName());
	SetStringValueAt("OwnerAttributeName", editedObject->GetOwnerAttributeName());

	// ## Custom refresh

	// ##
}

const ALString KWAttributeAxisNameArrayView::GetClassLabel() const
{
	return "Variable axiss";
}

// ## Method implementation

void KWAttributeAxisNameArrayView::SetMaxAxisNumber(int nValue)
{
	require(nValue >= 0);
	nMaxAxisNumber = nValue;
}

int KWAttributeAxisNameArrayView::GetMaxAxisNumber() const
{
	return nMaxAxisNumber;
}

void KWAttributeAxisNameArrayView::SetAttributeLabel(const ALString& sValue)
{
	sAttributeLabel = sValue;
}

const ALString& KWAttributeAxisNameArrayView::GetAttributeLabel()
{
	return sAttributeLabel;
}

void KWAttributeAxisNameArrayView::ActionInsertItemAfter()
{
	ALString sTmp;

	// Ajout d'une variable si possible
	if (nMaxAxisNumber == 0 or GetItemNumber() < nMaxAxisNumber)
		UIObjectArrayView::ActionInsertItemAfter();
	// Message d'erreur sinon
	else
	{
		if (sAttributeLabel == "")
			AddSimpleMessage(sTmp + "Max axis number is " + IntToString(nMaxAxisNumber));
		else
			AddSimpleMessage(sTmp + "Max " + sAttributeLabel + " variable number is " +
					 IntToString(nMaxAxisNumber));
	}
}

// ##
