import Swinject

public extension Resolver {
    func resolve<Service>(
        _ serviceType: Service.Type,
        name: String? = nil
    ) -> Service {
        guard let service = resolve(serviceType, name: name) else {
            fatalError("\(serviceType) dependency could not be resolved")
        }
        
        return service
    }
    
    func resolve<Service, Arg1>(
        _ serviceType: Service.Type,
        name: String? = nil,
        argument: Arg1
    ) -> Service {
        guard let service = resolve(serviceType, name: name, argument: argument) else {
            fatalError("\(serviceType) dependency could not be resolved")
        }
        
        return service
    }
    
    func resolve<Service, Arg1, Arg2>(
        _ serviceType: Service.Type,
        name: String? = nil,
        arguments arg1: Arg1, _ arg2: Arg2
    ) -> Service {
        guard let service = resolve(serviceType, name: name, arguments: arg1, arg2) else {
            fatalError("\(serviceType) dependency could not be resolved")
        }
        
        return service
    }
    
    func resolve<Service, Arg1, Arg2, Arg3>(
        _ serviceType: Service.Type,
        name: String? = nil,
        arguments arg1: Arg1, _ arg2: Arg2, _ arg3: Arg3
    ) -> Service {
        guard let service = resolve(serviceType, name: name, arguments: arg1, arg2, arg3) else {
            fatalError("\(serviceType) dependency could not be resolved")
        }
        
        return service
    }
}
