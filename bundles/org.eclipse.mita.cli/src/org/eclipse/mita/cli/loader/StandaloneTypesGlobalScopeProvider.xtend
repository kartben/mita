package org.eclipse.mita.cli.loader

import com.google.common.collect.Lists
import com.google.inject.Inject
import java.util.HashSet
import org.eclipse.emf.common.util.URI
import org.eclipse.emf.ecore.EReference
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.mita.base.scoping.ILibraryProvider
import org.eclipse.mita.base.scoping.TypesGlobalScopeProvider
import org.eclipse.xtext.resource.IResourceServiceProvider
import org.eclipse.xtext.scoping.Scopes
import org.eclipse.xtext.scoping.impl.SimpleScope

class StandaloneTypesGlobalScopeProvider extends TypesGlobalScopeProvider {
	
	@Inject
	private IResourceServiceProvider.Registry serviceProviderRegistry;
	
	@Inject
	private ILibraryProvider libraryProvider
	
	override protected getLibraryScope(Resource context, EReference reference) {
		val result = new HashSet();
		for(URI uri : libraryProvider.getDefaultLibraries()) {
			result.add(uri);
		}
		for(URI uri : libraryProvider.getImportedLibraries(context)) {
			result.add(uri);
		}
		
		val objDescriptions = (libraryProvider.getDefaultLibraries() + libraryProvider.getImportedLibraries(context)).flatMap[
			val resource = context.resourceSet.getResource(it, true);
			val resourceServiceProvider = serviceProviderRegistry.getResourceServiceProvider(it);
			
			if (resourceServiceProvider === null) {
				Scopes.scopedElementsFor(Lists.newArrayList(resource.getAllContents()));
			} else {
				val resourceDescription = resourceServiceProvider.getResourceDescriptionManager().getResourceDescription(resource);
				resourceDescription.getExportedObjects();
			}
		];
		return new SimpleScope(objDescriptions);
	}
	
}