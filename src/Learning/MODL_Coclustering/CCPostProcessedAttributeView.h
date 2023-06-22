// Copyright (c) 2023 Orange. All rights reserved.
// This software is distributed under the BSD 3-Clause-clear License, the text of which is available
// at https://spdx.org/licenses/BSD-3-Clause-Clear.html or see the "LICENSE" file for more details.

#pragma once

////////////////////////////////////////////////////////////
// 2021-02-05 18:19:44
// File generated  with GenereTable
// Insert your specific code inside "//## " sections

#include "UserInterface.h"

#include "CCPostProcessedAttribute.h"

// ## Custom includes

// ##

////////////////////////////////////////////////////////////
// Classe CCPostProcessedAttributeView
//    Coclustering variable
// Editeur de CCPostProcessedAttribute
class CCPostProcessedAttributeView : public UIObjectView
{
public:
	// Constructeur
	CCPostProcessedAttributeView();
	~CCPostProcessedAttributeView();

	// Acces a l'objet edite
	CCPostProcessedAttribute* GetCCPostProcessedAttribute();

	///////////////////////////////////////////////////////////
	// Redefinition des methodes a reimplementer obligatoirement

	// Mise a jour de l'objet par les valeurs de l'interface
	void EventUpdate(Object* object) override;

	// Mise a jour des valeurs de l'interface par l'objet
	void EventRefresh(Object* object) override;

	// Libelles utilisateur
	const ALString GetClassLabel() const override;

	// ## Custom declarations

	// ##
	////////////////////////////////////////////////////////
	//// Implementation
protected:
	// ## Custom implementation

	// ##
};

// ## Custom inlines

// ##