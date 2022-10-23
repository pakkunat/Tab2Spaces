//
//  main.swift
//  Tab2Spaces
//
//  Created by higaki koji on 2022/10/22.
//

import Foundation

func main() -> Int {
	// Get command line arguments.
	let arguments = CommandLine.arguments
	#if DEBUG
	print("arguments: \(arguments)")
	#endif
	if (arguments.count != 2) {
		print("error argument count = \(arguments.count)")
		return -1
	}
	
	// Read file.
	let url: URL
	if (arguments[1].contains("/")) {
		// In case of the absolute or relative path.
		url = URL(fileURLWithPath: arguments[1])
	} else {
		// In case of current directory.
		url = URL(fileURLWithPath: arguments[1], relativeTo: URL(fileURLWithPath: FileManager.default.currentDirectoryPath))
	}
	#if DEBUG
	print("file URL: \(url)")
	#endif

	guard let contents = try? String(contentsOf: url) else {
		fatalError("fail reading file.")
	}
	#if DEBUG
	print(contents)
	#endif
	
	// Replace tab code to 2 spaces.
	let newContents = contents.replacingOccurrences(of: "\t", with: "  ")
	#if DEBUG
	print(newContents)
	#endif
	
	// Write file.
	let ext = url.pathExtension
	let name = url.deletingPathExtension().lastPathComponent
	let newUrl = url.deletingLastPathComponent().appendingPathComponent(name + "_new." + ext)
	#if DEBUG
	print("new file URL: \(newUrl)")
	#endif
	guard let _ = try? newContents.write(to: newUrl, atomically: true, encoding: .utf8) else {
		fatalError("fail writing faile.")
	}

	return 0
}

_ = main()
