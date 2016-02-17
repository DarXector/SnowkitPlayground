package model;
import spod.model.SPODModel;

/**
 * Model helper singleton and register of all models used inside an app
 * .
 * @author Marko Ristic
 */

class ModelLocator
{
    // models used inside this app
	public var spodModel:SPODModel = new SPODModel();

	private static var _instance:ModelLocator;

	public function new() 
	{
        // Check if Model locatro has been initialised
		if( _instance != null ) trace( "Error:ModelLocator already initialised." );
		if( _instance == null ) _instance = this;
	}

	/**
     * Get instance of ModelLocator
     */
	public static inline function instance():ModelLocator
	{
		return initialize();
	}

    /**
     * Check if ModelLocator has been initialised, initialise it if not and return the instance of ModelLocator
     */
	public static function initialize():ModelLocator
	{
		if (_instance == null){
			_instance = new ModelLocator();
		}
		return _instance;
	}
	
}