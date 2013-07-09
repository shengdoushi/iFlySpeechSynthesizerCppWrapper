//
//  Cpp_IFlySpeechSynthesizer.h
//  MSCDemo
//
//  Created by guolihui on 13-7-9.
//
//

#pragma once
#include <string>
#include <tr1/memory>

// 前向声明
class Cpp_IFlySpeechSynthesizerDelegate;
class Cpp_IFlySpeechSynthesizerImpl;
class Cpp_IFlySpeechSynthesizer;

// 指针定义
typedef std::tr1::shared_ptr<Cpp_IFlySpeechSynthesizer> Ptr_Cpp_IFlySpeechSynthesizer;

class Cpp_IFlySpeechSynthesizer
{
public:
    static Ptr_Cpp_IFlySpeechSynthesizer createWithParams(const std::string& params, Cpp_IFlySpeechSynthesizerDelegate* delegate);
    
    void setDelegate(Cpp_IFlySpeechSynthesizerDelegate* delegate);
    
    // 暂时还不知道内部是怎么个情况，全局某个时刻只允许一个实例？
    // static Ptr_Cpp_IFlySpeechSynthesizer getSpeechSynthesizer();
    
    bool setParameter(const std::string& key, const std::string& value);
    void startSpeaking(const std::string& text);
    void pauseSpeaking();
    void resumeSpeaking();
    void stopSpeaking();
    
    ~Cpp_IFlySpeechSynthesizer();
private:
    Cpp_IFlySpeechSynthesizer(const std::string& params, Cpp_IFlySpeechSynthesizerDelegate* delegate);

    
    Cpp_IFlySpeechSynthesizerDelegate* m_pDelegate = nullptr;
    std::tr1::shared_ptr<Cpp_IFlySpeechSynthesizerImpl> m_ptrImpl;
};


class Cpp_IFlySpeechSynthesizerDelegate
{
public:
    virtual void onSpeakBegin(){}
    virtual void onBufferProgress(int progress, const std::string& msg){}
    virtual void onSpeakProgress(int progress){}
    virtual void onSpeakPaused(){}
    virtual void onSpeakResumed(){}
    virtual void onCompleted(int errorCode, int errorType){}
    virtual void onSpeakCancel(){}
};