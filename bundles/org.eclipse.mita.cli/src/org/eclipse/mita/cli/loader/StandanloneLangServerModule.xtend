package org.eclipse.mita.cli.loader

import com.google.inject.AbstractModule
import com.google.inject.Provider
import org.eclipse.xtext.resource.IResourceServiceProvider
import org.eclipse.xtext.resource.impl.ResourceServiceProviderRegistryImpl

class StandanloneLangServerModule extends AbstractModule {
	
	override protected configure() {
		bind(IResourceServiceProvider.Registry).toProvider(StandaloneResourceServiceProviderLoader);
	}
	
}

class StandaloneResourceServiceProviderLoader implements Provider<IResourceServiceProvider.Registry> {
	
	override get() {
		val registry = new ResourceServiceProviderRegistryImpl();
		for(entry: IResourceServiceProvider.Registry.INSTANCE.extensionToFactoryMap.entrySet) {
			registry.extensionToFactoryMap.put(entry.key, entry.value);
		}
 		return registry;
	}
	
}