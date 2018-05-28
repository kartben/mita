package org.eclipse.mita.cli.loader

import com.google.inject.Guice
import com.google.inject.Module
import com.google.inject.util.Modules
import org.eclipse.emf.ecore.resource.ResourceSet
import org.eclipse.mita.program.generator.ProgramDslGenerator

class StandaloneProgramDslGenerator extends ProgramDslGenerator {
	
	
	
	override protected injectPlatformDependencies(Module libraryModule) {
		injector = Guice.createInjector(Modules.override(injectingModule).with(new StandaloneModule()), libraryModule);
		injector.injectMembers(this);
	}
	
	override getUserFiles(ResourceSet set) {
		#[]
	}
	
}