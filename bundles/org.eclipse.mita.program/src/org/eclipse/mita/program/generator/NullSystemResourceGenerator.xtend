package org.eclipse.mita.program.generator

import org.eclipse.mita.program.ModalityAccess
import org.eclipse.mita.program.ModalityAccessPreparation
import org.eclipse.mita.program.SignalInstance

class NullSystemResourceGenerator extends AbstractSystemResourceGenerator {
	
	override generateSetup() {
		return CodeFragment.EMPTY;
	}
	
	override generateEnable() {
		return CodeFragment.EMPTY;
	}
	
	override generateModalityAccessFor(ModalityAccess modality) {
		return CodeFragment.EMPTY;
	}
	override generateAccessPreparationFor(ModalityAccessPreparation accessPreparation) {
		return CodeFragment.EMPTY;
	}
	override generateSignalInstanceGetter(SignalInstance signalInstance, String resultName) {
		return CodeFragment.EMPTY;
	}
	override generateSignalInstanceSetter(SignalInstance signalInstance, String valueVariableName) {
		return CodeFragment.EMPTY;
	}
	
}