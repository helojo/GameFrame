package com.frame.resource.loadtypes
{
    import com.frame.resource.*;

    public interface ILoad
    {

        function allocationFun(complete:Function, error:Function, progress:Function) : void;

        function setLoadingTesk(task:LoadingTask) : void;

        function setLoadingVO(vo:LoadingVO) : void;

        function load() : void;

        function stop() : void;

        function destroy() : void;

    }
}
