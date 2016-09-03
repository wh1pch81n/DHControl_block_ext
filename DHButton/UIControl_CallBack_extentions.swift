//
//  UIControl_CallBack_extentions.swift
//  DHButton
//
//  Created by Derrick  Ho on 9/3/16.
//  Copyright © 2016 Derrick  Ho. All rights reserved.
//

import UIKit

// a proxy class
internal class DHTargetActionProxy: UIView {
	// a block that will be called
	internal var _action: (AnyObject) -> ()
	
	internal init(controlEvents: UIControlEvents, action: (AnyObject) -> ()) {
		_action = action
		super.init(frame: CGRect.zero)
		self.tag = Int(controlEvents.rawValue)
	}
	
	internal required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	internal func action(_ sender: AnyObject) {
		_action(sender)
	}
}

extension UIControl {
	
	@objc
	public func callbackForControlEvents(_ controlEvents: UIControlEvents, withAction action: (AnyObject) -> ())
	{
		callback(when: controlEvents, with: action)
	}
	
}

extension UIControl: CallBackTargetAction {}

public protocol CallBackTargetAction {}

extension CallBackTargetAction where Self: UIControl {
	
	public func callback(when controlEvents: UIControlEvents = [UIControlEvents.touchUpInside],
	                          with action: (Self) -> ())
	{
		// An array of supported touch events
		let ctrlEvts: [UIControlEvents] =
			[
				.touchDown,
				.touchDownRepeat,
				.touchDragInside,
				.touchDragOutside,
				.touchDragEnter,
				.touchDragExit,
				.touchUpInside,
				.touchUpOutside,
				.touchCancel,
				
				.valueChanged,
				.editingDidBegin,
				.editingChanged,
				.editingDidEnd,
				.editingDidEndOnExit
		]
		
		ctrlEvts.forEach {
			if controlEvents.contains($0) {
				// each touch event requires its own proxy object
				_addActionToView(tag: $0.rawValue, action: { (ao: AnyObject) -> () in
					action(ao as! Self)
				})
			}
		}
	}
	
	private func _addActionToView(tag: UInt, action: (AnyObject) -> ()) {
		let foo = DHTargetActionProxy(controlEvents: UIControlEvents(rawValue: tag), action: action)
		
		// remove previous if it exists
		viewWithTag(Int(tag))?.removeFromSuperview()
		
		// since foo is not retained by target(_, action:, forControlEvents:) we must save it somewhere.  This implementation saves it as a subview.
		self.addSubview(foo)
		
		// add target to button.  Target instance is a proxy object and it calls a selector beloing to that proxy object.
		addTarget(foo, action: #selector(DHTargetActionProxy.action(_:)), for: UIControlEvents(rawValue: tag))
	}
	
}
