package org.eclipse.mita.cli.loader

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.emf.ecore.resource.ResourceSet
import org.eclipse.mita.cli.commands.CompileToCAdapter
import org.eclipse.mita.base.scoping.ILibraryProvider

class StandaloneLibraryProvider implements ILibraryProvider {
	protected ResourceSet resourceSet;

	static private ILibraryProvider instance = new StandaloneLibraryProvider();
	
	public static def ILibraryProvider getInstance() {
		return instance;
	}

	public def init(ResourceSet resourceSet) {
		this.resourceSet = resourceSet;
	}

	override getImportedLibraries(Resource context) {
		defaultLibraries;
	}
	
	override getDefaultLibraries() {
		if(resourceSet === null) {
			return #[]
		} else {
			return resourceSet.
				resources.
				filter[ 
					!it.eAdapters.exists[ 
						it instanceof CompileToCAdapter
					]
				]
				.map[ it.URI ];			
		}
		
	}
	
}