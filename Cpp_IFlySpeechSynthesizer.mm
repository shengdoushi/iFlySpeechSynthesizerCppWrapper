//
//  Cpp_IFlySpeechSynthesizer.m
//  MSCDemo
//
//  Created by guolihui on 13-7-9.
//
//

#include "Cpp_IFlySpeechSynthesizer.h"
#import "iflyMSC/IFlySpeechSynthesizer.h"

@interface Cpp_Objc_IFlySpeechSynthesizerDelegate : NSObject <IFlySpeechSynthesizerDelegate>
{
    Cpp_IFlySpeechSynthesizerDelegate* m_cppDelegate;
}
-(id)initWithCppDelegate:(Cpp_IFlySpeechSynthesizerDelegate*) delegate;
-(void)setDelegate:(Cpp_IFlySpeechSynthesizerDelegate*)delegate;
@end

@implementation Cpp_Objc_IFlySpeechSynthesizerDelegate
-(void)setDelegate:(Cpp_IFlySpeechSynthesizerDelegate *)delegate
{
    m_cppDelegate = delegate;
}
-(id)initWithCppDelegate:(Cpp_IFlySpeechSynthesizerDelegate *)delegate
{
    if ((self = [super init]))
    {
        m_cppDelegate = delegate;
    }
    return self;
}
-(void)onSpeakBegin
{
    if (m_cppDelegate)
        m_cppDelegate->onSpeakBegin();
}
-(void)onBufferProgress:(int)progress message:(NSString *)msg
{
    if (m_cppDelegate)
        m_cppDelegate->onBufferProgress(progress, [msg UTF8String]);
}
-(void)onSpeakProgress:(int)progress
{
    if (m_cppDelegate)
        m_cppDelegate->onSpeakProgress(progress);
}
-(void)onSpeakResumed
{
    if (m_cppDelegate)
        m_cppDelegate->onSpeakResumed();
}
-(void)onSpeakPaused
{
    if (m_cppDelegate)
        m_cppDelegate->onSpeakPaused();
}
- (void) onCompleted:(IFlySpeechError*) error
{
    if (m_cppDelegate)
        m_cppDelegate->onCompleted(-1, -1);
}
-(void)onSpeakCancel
{
    if (m_cppDelegate)
        m_cppDelegate->onSpeakCancel();
}
@end


class Cpp_IFlySpeechSynthesizerImpl
{
public:
    IFlySpeechSynthesizer *m_iflyobject = nil;
    Cpp_Objc_IFlySpeechSynthesizerDelegate *m_delegateWrapper = nil;
    
    Cpp_IFlySpeechSynthesizerImpl(const std::string& params, Cpp_IFlySpeechSynthesizerDelegate* delegate)
    {
        m_iflyobject = [[IFlySpeechSynthesizer createWithParams:[NSString stringWithUTF8String:params.c_str()] delegate:nil] retain];
        m_delegateWrapper = [[Cpp_Objc_IFlySpeechSynthesizerDelegate alloc] initWithCppDelegate:delegate];
    }
    ~Cpp_IFlySpeechSynthesizerImpl()
    {
        [m_delegateWrapper release];
        [m_iflyobject release];
    }
};

Cpp_IFlySpeechSynthesizer::Cpp_IFlySpeechSynthesizer(const std::string& params, Cpp_IFlySpeechSynthesizerDelegate* delegate)
:m_pDelegate(delegate)
{
    m_ptrImpl.reset(new Cpp_IFlySpeechSynthesizerImpl(params, delegate));
}
Cpp_IFlySpeechSynthesizer::~Cpp_IFlySpeechSynthesizer()
{
}

void Cpp_IFlySpeechSynthesizer::setDelegate(Cpp_IFlySpeechSynthesizerDelegate *delegate)
{
    [m_ptrImpl->m_delegateWrapper setDelegate:delegate];
}
Ptr_Cpp_IFlySpeechSynthesizer Cpp_IFlySpeechSynthesizer::createWithParams(const std::string &params, Cpp_IFlySpeechSynthesizerDelegate *delegate)
{
    return Ptr_Cpp_IFlySpeechSynthesizer(new Cpp_IFlySpeechSynthesizer(params, delegate));
}

bool Cpp_IFlySpeechSynthesizer::setParameter(const std::string& key, const std::string& value)
{
    return YES == [m_ptrImpl->m_iflyobject setParameter:[NSString stringWithUTF8String:key.c_str()] value:[NSString stringWithUTF8String:value.c_str()]];
}

void Cpp_IFlySpeechSynthesizer::startSpeaking(const std::string& text)
{
    [m_ptrImpl->m_iflyobject startSpeaking:[NSString stringWithUTF8String:text.c_str()]];
}

void Cpp_IFlySpeechSynthesizer::pauseSpeaking()
{
    [m_ptrImpl->m_iflyobject pauseSpeaking];
}

void Cpp_IFlySpeechSynthesizer::resumeSpeaking()
{
    [m_ptrImpl->m_iflyobject resumeSpeaking];
}

void Cpp_IFlySpeechSynthesizer::stopSpeaking()
{
    [m_ptrImpl->m_iflyobject stopSpeaking];
}