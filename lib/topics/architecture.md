# Presentation layer

## View

Flutter consists of only widgets,  
but widgets are classified into several types according to the form they are exposed on the screen.

1. Screen : Among the widgets, it is called on a screen-by-screen basis, and is mainly called by the
   Navigator.
2. Overlay : A widget that is stacked on top of the screen, and is a unit that covers all or part of
   the screen for a while and then disappears after performing a necessary function. Mainly called
   by OverlayEntry or showDialog or showModalBottomSheet.
3. Component : These are small unit widgets that make up a screen or overlay.

## ViewModel

In flutter app, ViewModel is a businiss logic component.  
It manages widget state. call UseCase and send changing event to View.

## Helper

Helper refers to reusable functions limited to service features.  
If it can be used universally, it has to be Util package.

# Domain layer

The domain layer is the main rules that make up the business,  
and it is composed of very small and simple codes,  
but its importance is no less than that of the other layers.  

Even if the server sends unnecessarily miscellaneous data,  
or if the UI seems very complicated compared to the business rules,  
it doesn't affect the domain layer.

## Entity

Minimum resources for business.  
It's not same as DTO VO.

## Usecase

Minimum features for business.

## Repository

This interface is defined to receive Entity from Data Layer.

# Data layer

The domain layer should not know anything about interfaces outside it.

Therefore, before the result of the action performed by the Repository is returned to UseCase,  
the implementation of the Repository must process and return the VO-type data retrieved through the API to Entity-type data.

## RepositoryImpl

As an implementation of the Repository,  
the implementation exists in the Data layer and knows the specifications of VO.  
returns an Entity.

## DataSource

Interface that is the rule of functions that receive data from API.

## Model

Specification for data transfer with API.  
In this code, only ResponseVO is described  
because the request transmission specification is set to Map to query string or Map to JSON.
- https://javiercbk.github.io/json_to_dart/

# Util

Util is code that can be reused for universal purposes other than projects,  
meaning general-purpose codes without platform/service dependencies.