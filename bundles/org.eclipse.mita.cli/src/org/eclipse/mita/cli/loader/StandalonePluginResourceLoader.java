package org.eclipse.mita.cli.loader;

import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.mita.program.resource.PluginResourceLoader;

import com.google.inject.Inject;
import com.google.inject.Injector;

public class StandalonePluginResourceLoader extends PluginResourceLoader {

	@Inject
	protected Injector injector;
	
	@Override
	public Object loadFromPlugin(Resource resource, String classname) {
		try {
			Class<?> clasz = getClass().getClassLoader().loadClass(classname);
			Object result = clasz.newInstance();
			injector.injectMembers(result);
			return result;
		} catch (InstantiationException | IllegalAccessException | ClassNotFoundException e) {
			e.printStackTrace();
			return null;
		}
	}
	
}
