// Copyright (c) 2023 Orange. All rights reserved.
// This software is distributed under the BSD 3-Clause-clear License, the text of which is available
// at https://spdx.org/licenses/BSD-3-Clause-Clear.html or see the "LICENSE" file for more details.

#pragma once

////////////////////////////////////////////////////////////
// 2021-02-05 18:19:44
// File generated  with GenereTable
// Insert your specific code inside "//## " sections

#include "UserInterface.h"

#include "CCPostProcessingSpec.h"

// ## Custom includes

#include "CCPostProcessedAttributeView.h"
#include "CCPostProcessedAttributeArrayView.h"

// ##

////////////////////////////////////////////////////////////
// Classe CCPostProcessingSpecView
//    Simplification parameters
// Editeur de CCPostProcessingSpec
class CCPostProcessingSpecView : public UIObjectView
{
public:
	// Constructeur
	CCPostProcessingSpecView();
	~CCPostProcessingSpecView();

	// Acces a l'objet edite
	CCPostProcessingSpec* GetCCPostProcessingSpec();

	///////////////////////////////////////////////////////////
	// Redefinition des methodes a reimplementer obligatoirement

	// Mise a jour de l'objet par les valeurs de l'interface
	void EventUpdate(Object* object) override;

	// Mise a jour des valeurs de l'interface par l'objet
	void EventRefresh(Object* object) override;

	// Libelles utilisateur
	const ALString GetClassLabel() const override;

	// ## Custom declarations

	// Parametrage de visibilite des contrainte de post-processing (initialement, tout est visible)
	void SetPostProcessingParametersVisible(boolean bValue);

	// Parametrage de l'objet edite
	void SetObject(Object* object) override;

	// ##
	////////////////////////////////////////////////////////
	//// Implementation
protected:
	// ## Custom implementation

	// ##
};

// ## Custom inlines

// ##