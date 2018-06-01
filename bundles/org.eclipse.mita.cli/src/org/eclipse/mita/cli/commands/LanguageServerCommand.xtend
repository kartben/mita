package org.eclipse.mita.cli.commands

import com.google.common.io.ByteStreams
import com.google.inject.Guice
import com.google.inject.util.Modules
import java.io.ByteArrayInputStream
import java.io.FileOutputStream
import java.io.PrintStream
import java.io.PrintWriter
import org.apache.commons.cli.Options
import org.eclipse.mita.cli.loader.StandaloneModule
import org.eclipse.mita.cli.loader.StandanloneLangServerModule
import org.eclipse.mita.program.ProgramDslRuntimeModule
import org.eclipse.xtext.ide.server.LaunchArgs
import org.eclipse.xtext.ide.server.ServerLauncher
import org.eclipse.xtext.ide.server.ServerModule
import org.eclipse.xtext.resource.IResourceFactory
import org.eclipse.xtext.resource.IResourceServiceProvider

class LanguageServerCommand extends AbstractCommand {
	
	override getOptions() {
		val result = new Options();
		result.addOption('t', 'trace', false, 'Enable tracing of incoming/outgoing messages');
		result.addOption('s', 'should-validate', false, 'Enable validation of incoming messages');
		result.addOption('d', 'debug', false, 'Log standard out for debugging');
		return result;
	}
	
	override run() {
		val launchArgs = new LaunchArgs
		launchArgs.in = System.in
		launchArgs.out = System.out
		
		System.setIn(new ByteArrayInputStream(newByteArrayOfSize(0)));
		if(this.commandLine.hasOption('d')) {
			System.setOut(new PrintStream(new FileOutputStream("mita-language-server-debug.log")));
		} else {
			System.setOut(new PrintStream(ByteStreams.nullOutputStream()));
		}
		
		if(this.commandLine.hasOption('t')) {
			launchArgs.trace = new PrintWriter(new FileOutputStream("mita-language-server-trace.log"));
		}
		launchArgs.validate = commandLine.hasOption('s');
		
		val programModule = Modules.override(new ProgramDslRuntimeModule()).with(new StandaloneModule(), Modules.override(new ServerModule()).with(new StandanloneLangServerModule()));
		val programInjector = Guice.createInjector(programModule);
		
		val languagesRegistry = programInjector.getInstance(IResourceServiceProvider.Registry);
		languagesRegistry.extensionToFactoryMap.put("mita", programInjector.getInstance(IResourceFactory));
		
		
		val launcher = programInjector.getInstance(ServerLauncher);
		launcher.start(launchArgs);
	}
	
}