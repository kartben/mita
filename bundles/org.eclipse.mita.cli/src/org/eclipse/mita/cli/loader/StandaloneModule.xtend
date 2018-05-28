package org.eclipse.mita.cli.loader

import com.google.inject.AbstractModule
import org.eclipse.mita.base.scoping.ILibraryProvider
import org.eclipse.mita.base.scoping.TypesGlobalScopeProvider
import org.eclipse.mita.program.generator.ProgramDslGenerator
import org.eclipse.mita.program.resource.PluginResourceLoader

class StandaloneModule extends AbstractModule {
	
	override protected configure() {
		bind(TypesGlobalScopeProvider).to(StandaloneTypesGlobalScopeProvider);
		bind(ILibraryProvider).toInstance(StandaloneLibraryProvider.getInstance());
		bind(ProgramDslGenerator).to(StandaloneProgramDslGenerator);
		bind(PluginResourceLoader).to(StandalonePluginResourceLoader);
	}
	
}